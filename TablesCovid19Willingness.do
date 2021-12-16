
***REPLICATION FILES FOR Frames That Matter: Increasing the Willingness to Get the Covid-19 Vaccines***

*use csv:  vaccinewillingness.csv and import delimited into Stata*
*make sure to preserve original capitalizing of letters*

label variable 	DVfull "willingness"
label variable 	agevar "age"
label variable  edu "edu"
label variable  incm "income"
label variable 	religion "religion"
label variable  MediaIndexscale "media_index_rescale"
label variable 	GovtServicesIndex "govt_services_orig"
label variable  GovtServicesIndexscale "govt_services"
label variable  MediaIndex "media_index_orig"
label variable  PartyLikert "party_likert"
label variable 	trust_gov "pol_trust"
label variable  Other2 "Other Racial Identity"
label variable 	trust_gov "pol_trust"
label variable 	flu "flu_shot"
label variable 	health "health_status"
label variable 	concernillness "concern_sick"
label variable  allergy   "severe_condition"
label variable 	ManipCorr "manip_correct"
label variable 	knowCovid19pat "know_covid"
label variable 	Incident_RatePct "incident_rate"
label variable 	lnCovid_Deaths "covid_deaths_log"
label variable 	Covid_Deaths "covid_deaths"


**FIGURES FIRST, FOLLOWED BY TABLES**

**This output is used for Figure 1; figure created in R for better appearance**

ttest E0_num3 == E1_num3, unpaired
ttest E0_num3 == E2_num3, unpaired
ttest E0_num3 == E3_num3, unpaired
ttest E0_num3 == E4_num3, unpaired
ttest E0_num3 == E5_num3, unpaired
ttest E0_num3 == E6_num3, unpaired
ttest E0_num3 == E7_num3, unpaired


**This output is used for Figure 3; figure created in R for better appearance**

ttest E0_num3 == E1_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E2_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E3_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E4_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E5_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E6_num3 if ManipCorr==1, unpaired
ttest E0_num3 == E7_num3 if ManipCorr==1, unpaired

 

***MAIN TEXT TABLES***

*Table 3*

gen treatment_num=treatment

ologit DVfull i.treatment_num, or ro
outreg2 using newTable3.xls, replace ctitle(Treatments) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion, or ro
outreg2 using newTable3.xls, append ctitle(Socio-Demographic) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov, or ro
outreg2 using newTable3.xls, append ctitle(Political Engagement, Views, Trust) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov MediaIndexscale, or ro
outreg2 using newTable3.xls, append ctitle(Media Exposure) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov MediaIndexscale health flu allergy concernillness knowCovid19pat, or ro
outreg2 using newTable3.xls, append ctitle(Personal Health Considerations) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale MediaIndexscale trust_gov health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths, or ro
outreg2 using newTable3.xls, append ctitle(Local Covid19 Situation) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label


*Predicted Value*

quietly ologit DVfull NurseLindsaydemo DrFaucidemo Bidenendorse Trumpendorse Fauciendorse FDA Economy agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale MediaIndexscale trust_gov health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths, or ro
margins, predict(outcome(6)) at(lnCovid_Deaths=0 lnCovid_Deaths=1 lnCovid_Deaths=2 lnCovid_Deaths=3 lnCovid_Deaths=4 lnCovid_Deaths=5 lnCovid_Deaths=6 lnCovid_Deaths=7 lnCovid_Deaths=8 lnCovid_Deaths=9) atmeans



**TABLES FOR THE APPENDIX**


*Table A1: Summary Statistics*

estpost summarize DVfull control NurseLindsaydemo DrFaucidemo Bidenendorse Trumpendorse Fauciendorse FDA Economy agevar edu incm gender Black Hispanic Asian White Mixed Other Other2 religion PartyLikert GovtServicesIndexscale MediaIndexscale health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths ManipCor trust_gov Event Time Time2 Time3 time_short time_mid time_short1 time_mid1
esttab, cells("count mean sd min max")



*Table A2:  Ordered Logit Predicting Willingness Using Four Survey Quotas*

ologit DVfull NurseLindsaydemo DrFaucidemo Bidenendorse Trumpendorse Fauciendorse FDA Economy agevar Black Hispanic Asian Mixed Other2 i.gender PartyLikert, or ro
outreg2 using DemographicBalance.xls, replace ctitle(All Variables) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform


*Table A3:  Replacing PartyLikert with IdeoLikert*

ologit DVfull i.treatment_num, or ro
outreg2 using IdeoLikert.xls, replace ctitle(Treatments) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion, or ro
outreg2 using IdeoLikert.xls, append ctitle(Socio-Demographic) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion IdeoLikert GovtServicesIndexscale trust_gov, or ro
outreg2 using IdeoLikert.xls, append ctitle(Political Engagement, Views, Trust) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion IdeoLikert GovtServicesIndexscale trust_gov MediaIndexscale, or ro
outreg2 using IdeoLikert.xls, append ctitle(Media Exposure) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion IdeoLikert GovtServicesIndexscale trust_gov MediaIndexscale health flu allergy concernillness knowCovid19pat, or ro
outreg2 using IdeoLikert.xls, append ctitle(Personal Health Considerations) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion IdeoLikert GovtServicesIndexscale MediaIndexscale trust_gov health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths, or ro
outreg2 using IdeoLikert.xls, append ctitle(Local Covid19 Situation) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label


*Table A4: Non-Cumulative and Cumulative Ordered Logit Models*

ologit DVfull i.treatment_num, or ro
outreg2 using newTable3A.xls, replace ctitle(Treatments) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion, or ro
outreg2 using newTable3A.xls, append ctitle(Socio-Demographic) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num PartyLikert GovtServicesIndexscale trust_gov, or ro
outreg2 using newTable3A.xls, append ctitle(Political Engagement, Views, Trust) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num MediaIndexscale, or ro
outreg2 using newTable3A.xls, append ctitle(Media Exposure) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num health flu allergy concernillness knowCovid19pat, or ro
outreg2 using newTable3A.xls, append ctitle(Personal Health Considerations) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num incident_ratepct lnCovid_Deaths, or ro
outreg2 using newTable3A.xls, append ctitle(Local Covid19 Situation) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov MediaIndexscale health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths, or ro
outreg2 using newTable3A.xls, append ctitle(All Variables) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label


*Table A5: Unadjusted P-values and Q-values for Ordered Logit Model 6*

* This code generates BKY (2006) sharpened two-stage q-values as described in Anderson (2008), "Multiple Inference and Gender Differences in the Effects of Early Intervention: A Reevaluation of the Abecedarian, Perry Preschool, and Early Training Projects", Journal of the American Statistical Association, 103(484), 1481-1495

* BKY (2006) sharpened two-stage q-values are introduced in Benjamini, Krieger, and Yekutieli (2006), "Adaptive Linear Step-up Procedures that Control the False Discovery Rate", Biometrika, 93(3), 491-507

* Last modified: M. Anderson, 11/20/07


*INSTRUCTIONS:
*Please start with a clear data set
*When prompted, paste the vector of p-values you are testing into the "pval" variable
*Please use the "do" button rather than the "run" button to run this file (if you use "run", you will miss the instructions at the prompts)

pause on
set more off

if _N>0 {
	display "Please clear data set before proceeding"
	display "After clearing, type 'q' to resume"
	pause
	}	

quietly gen float pval = .

display "***********************************"
display "Please paste the vector of p-values that you wish to test into the variable 'pval'"
display	"After pasting, type 'q' to resume"
display "***********************************"

pause

* Collect the total number of p-values tested

quietly sum pval
local totalpvals = r(N)

* Sort the p-values in ascending order and generate a variable that codes each p-value's rank

quietly gen int original_sorting_order = _n
quietly sort pval
quietly gen int rank = _n if pval~=.

* Set the initial counter to 1 

local qval = 1

* Generate the variable that will contain the BKY (2006) sharpened q-values

gen bky06_qval = 1 if pval~=.

* Set up a loop that begins by checking which hypotheses are rejected at q = 1.000, then checks which hypotheses are rejected at q = 0.999, then checks which hypotheses are rejected at q = 0.998, etc.  The loop ends by checking which hypotheses are rejected at q = 0.001.


while `qval' > 0 {
	* First Stage
	* Generate the adjusted first stage q level we are testing: q' = q/1+q
	local qval_adj = `qval'/(1+`qval')
	* Generate value q'*r/M
	gen fdr_temp1 = `qval_adj'*rank/`totalpvals'
	* Generate binary variable checking condition p(r) <= q'*r/M
	gen reject_temp1 = (fdr_temp1>=pval) if pval~=.
	* Generate variable containing p-value ranks for all p-values that meet above condition
	gen reject_rank1 = reject_temp1*rank
	* Record the rank of the largest p-value that meets above condition
	egen total_rejected1 = max(reject_rank1)

	* Second Stage
	* Generate the second stage q level that accounts for hypotheses rejected in first stage: q_2st = q'*(M/m0)
	local qval_2st = `qval_adj'*(`totalpvals'/(`totalpvals'-total_rejected1[1]))
	* Generate value q_2st*r/M
	gen fdr_temp2 = `qval_2st'*rank/`totalpvals'
	* Generate binary variable checking condition p(r) <= q_2st*r/M
	gen reject_temp2 = (fdr_temp2>=pval) if pval~=.
	* Generate variable containing p-value ranks for all p-values that meet above condition
	gen reject_rank2 = reject_temp2*rank
	* Record the rank of the largest p-value that meets above condition
	egen total_rejected2 = max(reject_rank2)

	* A p-value has been rejected at level q if its rank is less than or equal to the rank of the max p-value that meets the above condition
	replace bky06_qval = `qval' if rank <= total_rejected2 & rank~=.
	* Reduce q by 0.001 and repeat loop
	drop fdr_temp* reject_temp* reject_rank* total_rejected*
	local qval = `qval' - .001
}
	

quietly sort original_sorting_order
pause off
set more on

display "Code has completed."
display "Benjamini Krieger Yekutieli (2006) sharpened q-vals are in variable 'bky06_qval'"
display	"Sorting order is the same as the original vector of p-values"

*This ends Table A5/Q-value analysis*


*Table A6-A12:  Sub-sample analysis for hesitant groups*
*Table 6 is derived from the output of the below runs*


*Table A7: Republican*

gen Republican=.
replace Republican=0 if W5=="Democratic Party"
replace Republican=1 if W5=="Republican Party"
replace Republican=0 if W5=="Independent/no preference"
replace Republican=1 if W5c=="Closer to Republican Party"

ttest E0_num3 == E1_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E2_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E3_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E4_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E5_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E6_num3 if Republican==1, unpaired unequal 
ttest E0_num3 == E7_num3 if Republican==1, unpaired unequal 


*Table A8: Trump Vote*

ttest E0_num3 == E1_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E2_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E3_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E4_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E5_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E6_num3 if Trumpvote==1, unpaired unequal 
ttest E0_num3 == E7_num3 if Trumpvote==1, unpaired unequal 


*Table A9: Democrat*


gen Democrat=.
replace Democrat=1 if W5=="Democratic Party"
replace Democrat=0 if W5=="Republican Party"
replace Democrat=0 if W5=="Independent/no preference"
replace Democrat=1 if W5c=="Closer to Democratic Party"

ttest E0_num3 == E1_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E2_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E3_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E4_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E5_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E6_num3 if Democrat==1, unpaired unequal 
ttest E0_num3 == E7_num3 if Democrat==1, unpaired unequal 


*Table A10: Biden Vote*

ttest E0_num3 == E1_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E2_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E3_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E4_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E5_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E6_num3 if Bidenvote==1, unpaired unequal 
ttest E0_num3 == E7_num3 if Bidenvote==1, unpaired unequal 


*Table A11: African-American Respondents*

ttest E0_num3 == E1_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E2_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E3_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E4_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E5_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E6_num3 if Black==1, unpaired unequal 
ttest E0_num3 == E7_num3 if Black==1, unpaired unequal 


*Table A12: Female Respondents*

ttest E0_num3 == E1_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E2_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E3_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E4_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E5_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E6_num3 if fem==1, unpaired unequal 
ttest E0_num3 == E7_num3 if fem==1, unpaired unequal 


*Table A13:  Ordered Logit Models Predicting Willingness - Passed the Manipulation Check*

ologit DVfull i.treatment_num if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, replace ctitle(Treatments) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, append ctitle(Socio-Demographic) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, append ctitle(Political Engagement, Views, Trust) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov MediaIndexscale if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, append ctitle(Media Exposure) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale trust_gov MediaIndexscale health flu allergy concernillness knowCovid19pat if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, append ctitle(Personal Health Considerations) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label

ologit DVfull i.treatment_num agevar edu incm i.gender Black Hispanic Asian Mixed Other2 religion PartyLikert GovtServicesIndexscale MediaIndexscale trust_gov health flu allergy concernillness knowCovid19pat incident_ratepct lnCovid_Deaths if ManipCorr==1, or ro
outreg2 using newTable3manip.xls, append ctitle(Local Covid19 Situation) stats(coef se pval) addstat(Model chi-square, e(chi2), df, e(df_m), Loglikelihood, e(ll), Pseudo R2, e(r2_p))  eform label






