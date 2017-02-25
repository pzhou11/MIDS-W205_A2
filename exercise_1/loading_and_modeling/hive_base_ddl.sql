DROP TABLE HCAHPS_Hospital_Detail;

CREATE EXTERNAL TABLE HCAHPS_Hospital_Detail 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  phone_number string,
  hcahps_measure_id string,
  hcahps_question string,
  hcahps_answer_description string,
  patient_survey_star_rating string,
  patient_survey_star_rating_footnote string,
  hcahps_answer_percent string,
  hcahps_answer_percent_footnote string,
  number_of_completed_surveys string,
  number_of_completed_surveys_footnote string,
  survey_response_rate_percent string,
  survey_response_rate_percent_footnote string,
  measure_start_date string,
  measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hcahps_detail'
;


DROP TABLE HCAHPS_Hospital_Summary;

CREATE EXTERNAL TABLE HCAHPS_Hospital_Summary 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  communication_with_nurses_achievement_points string,
  communication_with_nurses_improvement_points string,
  communication_with_nurses_dimension_score string,
  communication_with_doctors_achievement_points string,
  communication_with_doctors_improvement_points string,
  communication_with_doctors_dimension_score string,
  responsiveness_of_hospital_staff_achievement_points string,
  responsiveness_of_hospital_staff_improvement_points string,
  responsiveness_of_hospital_staff_dimension_score string,
  pain_management_achievement_points string,
  pain_management_improvement_points string,
  pain_management_dimension_score string,
  communication_about_medicines_achievement_points string,
  communication_about_medicines_improvement_points string,
  communication_about_medicines_dimension_score string,
  cleanliness_and_quietness_of_hospital_achievement_points string,
  cleanliness_and_quietness_of_hospital_improvement_points string,
  cleanliness_and_quietness_of_hospital_dimension_score string,
  discharge_information_achievement_points string,
  discharge_information_improvement_points string,
  discharge_information_dimension_score string,
  overall_rating_of_hospital_achievement_points string,
  overall_rating_of_hospital_improvement_points string,
  overall_rating_of_hospital_score_dimension string,
  hcahps_base_score string,
  hcahps_consistency_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hcahps_summary'
;


DROP TABLE Hospital_General_Info;

CREATE EXTERNAL TABLE Hospital_General_Info 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  phone_number string,
  hospital_type string,
  hospital_ownership string,
  emergency_services string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospital_general_info'
;


DROP TABLE Measure_Dates;

CREATE EXTERNAL TABLE Measure_Dates 
(
  measure_name string, 
  measure_id string,
  measure_start_quarter string,
  measure_start_date string,
  measure_end_quarter string,
  measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measure_dates'
;


DROP TABLE Readmissions_and_Deaths_Hospital;

CREATE EXTERNAL TABLE Readmissions_and_Deaths_Hospital 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  phone_number string,
  measure_name string,
  measure_id string,
  compared_to_national string,
  denominator string,
  score string,
  lower_estimate string,
  higher_estimate string,
  footnote string,
  measure_start_date string,
  measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions_and_deaths'
;


DROP TABLE Timely_and_Effective_Care_Hospital;

CREATE EXTERNAL TABLE Timely_and_Effective_Care_Hospital 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  phone_number string,
  condition string,
  measure_id string,
  measure_name string,
  score string,
  sample string,
  footnote string,
  measure_start_date string,
  measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/timely_and_effective_care'
;


DROP TABLE Complications_Hospital;

CREATE EXTERNAL TABLE Complications_Hospital 
(
  provider_id string, 
  hospital_name string,
  address string,
  city string,
  state string,
  zip_code string,
  county_name string,
  phone_number string,
  measure_name string,
  measure_id string,
  compared_to_national string,
  denominator string,
  score string,
  lower_estimate string,
  higher_estimate string,
  footnote string,
  measure_start_date string,
  measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",", 
  "quoteChar" = '"',
  "escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/complications_hospital'
;
