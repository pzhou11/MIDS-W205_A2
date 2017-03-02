drop table best_hcahps_detail_filter;

create table best_hcahps_detail_filter as
select
  provider_id,
  measure_id,
  number_of_completed_surveys,
  survey_response_rate_percent
from hcahps_detail
where number_of_completed_surveys>=300 and
  survey_response_rate_percent>=20 and
  measure_id='H_HSP_RATING_LINEAR_SCORE'
;



drop table best_complications_filter;

create table best_complications_filter as
select
  provider_id,
  measure_id,
  compared_to_national,
  denominator,
  score
from complications
where denominator>=100 and
  measure_id not like 'PSI_8%'
;



drop table best_complications_filter2;

create table best_complications_filter2 as
select
  provider_id,
  count(provider_id) as count
from best_complications_filter
group by provider_id
having count>=7
;


drop table best_readmission_filter;

create table best_readmission_filter as
select
  provider_id,
  measure_id,
  compared_to_national,
  denominator,
  score
from readmissions_and_deaths
where denominator>=50 and
  denominator not like 'Not%'
;


drop table best_readmission_filter2;

create table best_readmission_filter2 as
select
  provider_id,
  count(provider_id) as count
from best_readmission_filter
group by provider_id
having count>=10
;


drop table best_hcahps_summary_filter_final;

create table best_hcahps_summary_filter_final as 
select
  hcahps_summary.provider_id,
  hcahps_summary.overall_performance
from hcahps_summary 
inner join best_hcahps_detail_filter 
  on hcahps_summary.provider_id = best_hcahps_detail_filter.provider_id
inner join best_complications_filter2
  on hcahps_summary.provider_id = best_complications_filter2.provider_id
inner join best_readmission_filter2
  on hcahps_summary.provider_id = best_readmission_filter2.provider_id
;


drop table best_complications_filter_final;

create table best_complications_filter_final as 
select
  best_complications_filter.provider_id,
  sum(case when compared_to_national='Better than the National Rate' then 1 else 0 end) as best
from best_complications_filter
inner join best_hcahps_summary_filter_final
  on best_complications_filter.provider_id = best_hcahps_summary_filter_final.provider_id
group by best_complications_filter.provider_id
;



drop table best_readmission_filter_final;

create table best_readmission_filter_final as 
select
  best_readmission_filter.provider_id,
  sum(case when compared_to_national='Better than the National Rate' then 1 else 0 end) as best
from best_readmission_filter
inner join best_hcahps_summary_filter_final
  on best_readmission_filter.provider_id = best_hcahps_summary_filter_final.provider_id
group by best_readmission_filter.provider_id
;



drop table best_hospital1;

create table best_hospital1 as 
select
  best_hcahps_summary_filter_final.provider_id,
  best_hcahps_summary_filter_final.overall_performance,
  best_readmission_filter_final.best as readmission_score,
  best_complications_filter_final.best as complications_score
from best_hcahps_summary_filter_final
inner join best_readmission_filter_final
  on best_hcahps_summary_filter_final.provider_id = best_readmission_filter_final.provider_id
inner join best_complications_filter_final
  on best_hcahps_summary_filter_final.provider_id = best_complications_filter_final.provider_id
;



drop table best_hospital_final;

create table best_hospital_final as
SELECT 
  best_hospital1.provider_id,
  hospital_info.hospital_name,
  round(((RANK() OVER (ORDER BY best_hospital1.overall_performance DESC)) +
  (RANK() OVER (ORDER BY best_hospital1.readmission_score DESC)) +
  (RANK() OVER (ORDER BY best_hospital1.complications_score DESC))) / 3,1) as overall_score,
  (RANK() OVER (ORDER BY best_hospital1.overall_performance DESC)) as HCAHPS_rank,
  (RANK() OVER (ORDER BY best_hospital1.readmission_score DESC)) as readmission_rank,
  (RANK() OVER (ORDER BY best_hospital1.complications_score DESC)) as complications_rank
from best_hospital1
inner join hospital_info
  on best_hospital1.provider_id = hospital_info.provider_id
order by overall_score asc
;

select * from best_hospital_final limit 10;
