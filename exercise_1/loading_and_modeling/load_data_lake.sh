#! /bin/bash

# save the current directory
MY_CWD=$(pwd)

# create staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging directory
cd ~/staging/exercise_1

# get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip" 
wget "$MY_URL" -O medicare_data.zip

# unzip data
unzip medicare_data.zip

# original file names
OLD_READMISSIONS="Readmissions and Deaths - Hospital.csv"
OLD_TIMELY="Timely and Effective Care - Hospital.csv"
OLD_HOSP_INFO="Hospital General Information.csv"
OLD_HCAHPS_SUMMARY="hvbp_hcahps_11_10_2016.csv"
OLD_COMPLICATIONS="Complications - Hospital.csv"
OLD_HCAHPS_DETAIL="HCAHPS - Hospital.csv"

# NEW file names
NEW_READMISSIONS="Readmissions_and_Deaths_Hospital.csv"
NEW_TIMELY="Timely_and_Effective_Care_Hospital.csv"
NEW_HOSP_INFO="Hospital_General_Info.csv"
NEW_HCAHPS_SUMMARY="HCAHPS_Hospital_Summary.csv"
NEW_COMPLICATIONS="Complications_Hospital.csv"
NEW_HCAHPS_DETAIL="HCAHPS_Hospital_Detail.csv"

# remove first line of files and rename
tail -n +2 "$OLD_READMISSIONS" >$NEW_READMISSIONS
tail -n +2 "$OLD_TIMELY" >$NEW_TIMELY
tail -n +2 "$OLD_HOSP_INFO" >$NEW_HOSP_INFO
tail -n +2 "$OLD_HCAHPS_SUMMARY" >$NEW_HCAHPS_SUMMARY
tail -n +2 "$OLD_COMPLICATIONS" >$NEW_COMPLICATIONS
tail -n +2 "$OLD_HCAHPS_DETAIL" >$NEW_HCAHPS_DETAIL

# create hdfs director
hdfs dfs -mkdir /user/w205/hospital_compare

#create hdfs directory for each file and copy each file to hdfs
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_and_deaths
hdfs dfs -put $NEW_READMISSIONS /user/w205/hospital_compare/readmissions_and_deaths

hdfs dfs -mkdir /user/w205/hospital_compare/timely_and_effective_care
hdfs dfs -put $NEW_TIMELY /user/w205/hospital_compare/timely_and_effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/hospital_general_info
hdfs dfs -put $NEW_HOSP_INFO /user/w205/hospital_compare/hospital_general_info

hdfs dfs -mkdir /user/w205/hospital_compare/hcahps_summary
hdfs dfs -put $NEW_HCAHPS_SUMMARY /user/w205/hospital_compare/hcahps_summary

hdfs dfs -mkdir /user/w205/hospital_compare/complications_hospital
hdfs dfs -put $NEW_COMPLICATIONS /user/w205/hospital_compare/complications_hospital

hdfs dfs -mkdir /user/w205/hospital_compare/hcahps_detail
hdfs dfs -put $NEW_HCAHPS_DETAIL /user/w205/hospital_compare/hcahps_detail

# change directory back to original
cd $MY_CWD

# clean exit
exit

