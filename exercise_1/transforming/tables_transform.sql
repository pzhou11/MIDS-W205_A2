drop table hospital_info;

create table hospital_info as
select
  provider_id,
  hospital_name,
  address,
  city,
  state,
  zip_code,
  county_name,
  phone_number,
  hospital_type,
  hospital_ownership,
  emergency_services
from hospital_general_info
;


drop table complications;

create table complications as
select
  provider_id,
  measure_name,
  measure_id,
  compared_to_national,
  denominator,
  score,
  lower_estimate,
  higher_estimate,
  cast(
    concat(substr(measure_start_date, 7, 4),
           '-',
           substr(measure_start_date, 1, 2),
           '-',
           substr(measure_start_date, 4, 2)
           )
    as date) as measure_start_date,
  cast(
    concat(substr(measure_end_date, 7, 4),
           '-',
           substr(measure_end_date, 1, 2),
           '-',
           substr(measure_end_date, 4, 2)
           )
    as date) as measure_end_date
from complications_hospital
;



drop table readmissions_and_deaths;

create table readmissions_and_deaths as
select
  provider_id,
  measure_name,
  measure_id,
  compared_to_national,
  denominator,
  score,
  lower_estimate,
  higher_estimate,
  cast(
    concat(substr(measure_start_date, 7, 4),
           '-',
           substr(measure_start_date, 1, 2),
           '-',
           substr(measure_start_date, 4, 2)
           )
    as date) as measure_start_date,
  cast(
    concat(substr(measure_end_date, 7, 4),
           '-',
           substr(measure_end_date, 1, 2),
           '-',
           substr(measure_end_date, 4, 2)
           )
    as date) as measure_end_date
from readmissions_and_deaths_hospital
;


drop table timely_and_effective;

create table timely_and_effective as
select
  provider_id,
  condition,
  measure_id,
  measure_name,
  score,
  sample,
  cast(
    concat(substr(measure_start_date, 7, 4),
           '-',
           substr(measure_start_date, 1, 2),
           '-',
           substr(measure_start_date, 4, 2)
           )
    as date) as measure_start_date,
  cast(
    concat(substr(measure_end_date, 7, 4),
           '-',
           substr(measure_end_date, 1, 2),
           '-',
           substr(measure_end_date, 4, 2)
           )
    as date) as measure_end_date
from timely_and_effective_care_hospital
;



drop table hcahps_detail;

create table hcahps_detail as
select
  provider_id,
  hcahps_measure_id as measure_id,
  hcahps_question as question,
  hcahps_answer_description as answer,
  patient_survey_star_rating as patient_rating,
  hcahps_answer_percent as answer_percent,
  hcahps_linear_mean_value as linear_mean_value,
  number_of_completed_surveys,
  survey_response_rate_percent,
  cast(
    concat(substr(measure_start_date, 7, 4),
           '-',
           substr(measure_start_date, 1, 2),
           '-',
           substr(measure_start_date, 4, 2)
           )
    as date) as measure_start_date,
  cast(
    concat(substr(measure_end_date, 7, 4),
           '-',
           substr(measure_end_date, 1, 2),
           '-',
           substr(measure_end_date, 4, 2)
           )
    as date) as measure_end_date
from hcahps_hospital_detail
;


drop table hcahps_summary;

create table hcahps_summary as
select
  provider_id,
  communication_with_nurses_performance_rate as nurse_performance,
  communication_with_nurses_achievement_points as nurse_achievement,
  communication_with_doctors_performance_rate as doctor_performance,
  communication_with_doctors_achievement_points as doctor_achievement,
  responsiveness_of_hospital_staff_performance_rate as staff_performance,
  responsiveness_of_hospital_staff_achievement_points as staff_achievement,
  pain_management_performance_rate as pain_performance,
  pain_management_achievement_points as pain_achievement,
  communication_about_medicines_performance_rate as medicines_performance,
  communication_about_medicines_achievement_points as medicines_achievement,
  cleanliness_and_quietness_of_hospital_performance_rate as clean_performance,
  cleanliness_and_quietness_of_hospital_achievement_points as clean_achievement,
  discharge_information_performance_rate as discharge_performance,
  discharge_information_achievement_points as discharge_achievement,
  overall_rating_of_hospital_performance_rate as overall_performance,
  overall_rating_of_hospital_achievement_points as overall_achievement,
  hcahps_base_score as base_score,
  hcahps_consistency_score as consistency_score
from hcahps_hospital_summary
;
