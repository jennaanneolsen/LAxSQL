--create the type
create or replace type psycho_results as object(
  code varchar2(4000),
  p_val number,
  ptbis decimal(5,3)); 
/
create or replace type psycho_results_nt as table of psycho_results;  
/

create or replace function get_psycho_results (crs_number in wgubi.vw_rst_objective_assessment.course_number%type, st_date in wgubi.vw_rst_objective_assessment.assess_date%type)
  return psycho_results_nt
is
  return_value psycho_results_nt;
begin
  select psycho_results(code, p_val, ptbis) 
  bulk collect into return_value
  from (
    select code, p_val
      , (((num_attempts*sum_itemtot)-(sum_item*sum_total))/
     (sqrt(((num_attempts*sum_itemsq)-(sum_item*sum_item))*((num_attempts*sum_totalsq)-(sum_total*sum_total)))+.0000001)) as ptbis
    from (
      select distinct code, count(distinct(assess_attempt_id)) as num_attempts, sum(points) as sum_item, avg(points) as p_val, sum(item_sq) as sum_itemsq
        ,sum(total) as sum_total, sum(total_sq) as sum_totalsq, sum(total_item) as sum_itemtot
      from (
      select assess_attempt_id, course_number, points, code, point_score, point_score - points as total, points*points as item_sq
        ,(point_score - points)*(point_score - points) as total_sq, points*(point_score - points) as total_item
      from wgubi.vw_rst_objective_assessment
      where trunc(assess_date) > st_date
      and course_number = crs_number
      )pt2
      group by code 
    )pt3
  )pt_all;
  return return_value;
end;
/

select * from table(get_psycho_results('CEC1',to_date('31-DEC-17')));

/*
--Create table with results 
create table temp_pt_test as 
select * from table(get_psycho_results('CEC1',to_date('31-DEC-17')));

--test with existing code
select iaf.*, pt.*
from temp_IA_Final_JOintials iaf
  join temp_pt_test pt on iaf.code = pt.code
where iaf.p_val != pt.p_val;

select iaf.*, pt.*
from temp_IA_Final_JOintials iaf
  join temp_pt_test pt on iaf.code = pt.code
where iaf.ptbis != pt.ptbis;
*/

  