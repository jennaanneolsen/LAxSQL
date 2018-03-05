select student_pidm, course_code, assess_date, points, full_objective_item_code, assess_attempt_id, pct_score as assess_pct_score, pass_score as assess_pct_to_pass, assess_delivery_type, assess_duration, item_duration 
  ,item_duration/assess_duration as item_pct_of_assess_time
from wgubi.vw_rst_objective_assessment where assess_delivery_type != 'Preassessment' and rownum < 11;