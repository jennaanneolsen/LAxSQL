case 
            when ASMT_FORM is null then 
            case 
                when  ASSESSMENT_FORM_VERSION like '%Set1%' then 'A'
                when  ASSESSMENT_FORM_VERSION like '%Set2%' then 'B'
                when  ASSESSMENT_FORM_VERSION like '%Set3%' then 'C'
                when  ASSESSMENT_FORM_VERSION like '%Set4%' then 'D'
                when  ASSESSMENT_FORM_VERSION like '%Set 1%' then 'A'
                when  ASSESSMENT_FORM_VERSION like '%Set 2%' then 'B'
                when  ASSESSMENT_FORM_VERSION like '%Set 3%' then 'C'
                when  ASSESSMENT_FORM_VERSION like '%Set 4%' then 'D'
                else 'NA' end
            when  ASMT_VERSION like '%A%' then ASMT_VERSION 
            when  ASMT_VERSION like '%B%' then ASMT_VERSION 
            when  ASMT_VERSION like '%C%' then ASMT_VERSION 
            when  ASMT_VERSION like '%D%' then ASMT_VERSION 
            else  ASMT_FORM end AS ASMT_FORM,
        case 
            when ASMT_VERSION is null then '1'
            when  ASMT_VERSION like '%A%' then ASMT_FORM 
            when  ASMT_VERSION like '%B%' then ASMT_FORM 
            when  ASMT_VERSION like '%C%' then ASMT_FORM
            when  ASMT_VERSION like '%D%' then ASMT_FORM
            when  ASMT_VERSION like '%Set1%' then ASMT_FORM
            when  ASMT_VERSION like '%Set2%' then ASMT_FORM
            when  ASMT_VERSION like '%Set3%' then ASMT_FORM
            when  ASMT_VERSION like '%Set4%' then ASMT_FORM
            else  ASMT_VERSION end as ASMT_VERSION,
