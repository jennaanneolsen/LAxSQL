select distinct(a.student_pidm), a.term_code, a.course_number, coalesce(c.calendar_date, m.last_active_date) as last_date_in_course, c.course_completion
from wgubi.vw_rst_assessment a
      join  (
      select student_pidm, term_code, max(calendar_date) as last_active_date, course_number
      from wgubi.vw_rst_assessment 
      group by student_pidm, term_code, course_number
      )m on a.student_pidm = m.student_pidm and a.term_code = m.term_code and a.course_number = m.course_number
      left outer join wgubi.vw_rst_assessment c on 
        a.student_pidm = c.student_pidm and a.term_code = c.term_code and a.course_number = c.course_number and c.course_completion = 1
 where a.student_pidm = 97789 and a.term_code = 201006      
      ;
     
