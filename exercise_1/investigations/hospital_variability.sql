select
  measure_name,
  round(stddev(score),2) as stdev_score
from readmissions_and_deaths
where score not like 'Not%'
group by measure_name
order by stdev_score desc
;



select
  measure_name,
  round(stddev(score),2) as stdev_score
from complications
where score not like 'Not%'
group by measure_name
order by stdev_score desc
;


