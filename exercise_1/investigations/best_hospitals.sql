drop table hcahps_detail_best_filter;

create table hcahps_detail_best_filter as
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



drop table complications_best_filter;

create table complications_best_filter as
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



drop table complications_best_filter2;

create table complications_best_filter2 as
select
  provider_id,
  count(provider_id) as count
from complications_best_filter
group by provider_id
having count>=9
;


drop table readmission_best_filter;

create table readmission_best_filter as
select
  provider_id,
  measure_id,
  compared_to_national,
  denominator,
  score
from readmissions_and_deaths
where denominator>=100 and
  denominator not like 'Not%'
;


drop table readmission_best_filter2;

create table readmission_best_filter2 as
select
  provider_id,
  count(provider_id) as count
from readmission_best_filter
group by provider_id
having count>=12
;


drop table hcahps_summary_filter_final;

create table hcahps_summary_filter_final as 
select
  hcahps_summary.provider_id,
  hcahps_summary.overall_performance
from hcahps_summary 
inner join hcahps_detail_best_filter 
  on hcahps_summary.provider_id = hcahps_detail_best_filter.provider_id
inner join complications_best_filter2
  on hcahps_summary.provider_id = complications_best_filter2.provider_id
inner join readmission_best_filter2
  on hcahps_summary.provider_id = readmission_best_filter2.provider_id
;


drop table complications_best_filter_final;

create table complications_best_filter_final as 
select
  complications_best_filter.provider_id,
  sum(case when compared_to_national='Better than the National Rate' then 1 else 0 end) -
  sum(case when compared_to_national='Worse than the National Rate' then 1 else 0 end) as net
from complications_best_filter
inner join hcahps_summary_filter_final
  on complications_best_filter.provider_id = hcahps_summary_filter_final.provider_id
group by complications_best_filter.provider_id
;



drop table readmission_best_filter_final;

create table readmission_best_filter_final as 
select
  readmission_best_filter.provider_id,
  sum(case when compared_to_national='Better than the National Rate' then 1 else 0 end) -
  sum(case when compared_to_national='Worse than the National Rate' then 1 else 0 end) as net
from readmission_best_filter
inner join hcahps_summary_filter_final
  on readmission_best_filter.provider_id = hcahps_summary_filter_final.provider_id
group by readmission_best_filter.provider_id
;



drop table best_hospital1;

create table best_hospital1 as 
select
  hcahps_summary_filter_final.provider_id,
  hcahps_summary_filter_final.overall_performance,
  readmission_best_filter_final.net as readmission_score,
  complications_best_filter_final.net as complications_score
from hcahps_summary_filter_final
inner join readmission_best_filter_final
  on hcahps_summary_filter_final.provider_id = readmission_best_filter_final.provider_id
inner join complications_best_filter_final
  on hcahps_summary_filter_final.provider_id = complications_best_filter_final.provider_id
;



drop table best_hospital_final;

create table best_hospital_final as
SELECT 
  best_hospital1.provider_id,
  hospital_info.hospital_name,
  ((RANK() OVER (ORDER BY best_hospital1.overall_performance DESC)) +
  (RANK() OVER (ORDER BY best_hospital1.readmission_score DESC)) +
  (RANK() OVER (ORDER BY best_hospital1.complications_score DESC))) / 3 as score
from best_hospital1
inner join hospital_info
  on best_hospital1.provider_id = hospital_info.provider_id
order by score asc
;
