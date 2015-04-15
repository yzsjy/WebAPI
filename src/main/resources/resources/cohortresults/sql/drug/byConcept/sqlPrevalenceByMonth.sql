select c1.concept_id as concept_id,
	c1.concept_name as concept_name,
	num.stratum_2 as x_calendar_month,
	round(1000*(1.0*num.count_value/denom.count_value),5) as y_prevalence_1000pp
from 
	(select * from @ohdsi_database_schema.heracles_results where analysis_id = 702 and cohort_definition_id in (@cohortDefinitionId)) num
	inner join
	(select * from @ohdsi_database_schema.heracles_results where analysis_id = 117 and cohort_definition_id in (@cohortDefinitionId)) denom
	on num.stratum_2 = denom.stratum_1  --calendar year
	inner join
	@cdm_database_schema.concept c1
	on CAST(num.stratum_1 AS INT) = c1.concept_id
WHERE c1.concept_id = @conceptId
ORDER BY CAST(num.stratum_2 as INT)
