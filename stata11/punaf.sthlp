{smcl}
{hline}
help for {cmd:punaf}{right:(Roger Newson)}
{hline}

{title:Population attributable and unattributable fractions for cohort and cross-sectional studies}

{p 8 21 2}
{cmd:punaf} {ifin} {weight} , {opt at:spec(atspec)}
  [ {opt subpop(subspec)} {opt vce(vcespec))} {opt iter:ate(#)} {opt ef:orm} {opt l:evel(#)} {opt post}
  ]

{pstd}
where {it:atspec} is an at-specification recognized by the {cmd:at()} option of {helpb margins},
{it:subspec} is a subpopulation specificarion of the form recognized by the {cmd:subpop()} option of {helpb margins},
and {it:vcespec} is a variance-covariance specification of the form recognized by {helpb margins},
and must have one of the values

{pstd}
{cmd:delta} | {cmd:unconditional}

{pstd}
{cmd:fweight}s, {cmd:aweight}s, {cmd:iweight}s, {cmd:pweight}s are allowed;
see {help weight}.


{title:Description}

{pstd}
{cmd:punaf} calculates confidence intervals for population attributable fractions,
and also for scenario means and their ratio, known as the population unattributable fraction.
{cmd:punaf} can be used after an estimation command whose {help predict:predicted values} are interpreted as conditional arithmetic means,
such as {helpb logit}, {helpb logistic}, {helpb poisson}, or {helpb glm}.
It estimates the logs of two scenario means,
the baseline scenario ("Scenario 0") and a fantasy scenario ("Scenario 1"),
in which one or more exposure variables are assumed to be set to particular values (typically zero),
and any other predictor variables in the model are assumed to remain the same.
It also estimates the log of the ratio of the Scenario 1 mean to the Scenario 0 mean.
This ratio is known as the population unattributable fraction,
and is subtracted from 1 to derive the population attributable fraction,
defined as the proportion of the mean of the outcome variable attributable
to living in Scenario 0 instead of Scenario 1.


{title:Options for {cmd:punaf}}

{phang}
{opt atspec(atspec)} is an at-specification,
allowed as a value of the {cmd:at()} option of {helpb margins}.
This at-specification specifies a scenario ("Scenario 1"),
defined as a fantasy world in which a subset of the predictor variables in the model
are set to values different from their value in the real-life baseline scenario (denoted "Scenario 0").
{cmd:punaf} uses the {helpb margins} command to estimate the arithmetic mean values of the outcome
under Scenarios 0 and 1,
and then uses {helpb nlcom} to estimate the logs of these 2 scenario means,
and of the ratio of the Scenario 1 mean to the Scenario 0 mean,
known as the population unattributable fraction (PUF).
The PUF, and its confidence limits, are subtracted from 1
to calculate a confidence interval for the population attributable fraction (PAF).

{phang}
{opt subpop(subspec)} and {opt vce(vcespec)} have the same form and function as the options of the same names for {helpb margins}.
They specify the subpopulation and the variance-covariance matrix formula, respectively,
used to estimate the scenario means,
and therefore to estimate the population unattributable and attributable fractions.

{phang}
{opt iterate(#)} has the same form and function as the option of the same name for {helpb nlcom}.
It specifies the number of iterations used by {helpb nlcom}
to find the optimal step size to calculate the numerical derivatives
of the logs of the scenario means and of their ratio,
with respect to the original scenario means calculated by {helpb margins}.

{phang}
{opt eform} specifies that {cmd:punaf} will display estimates, {it:P}-values and confidence limits
for the scenario means and their ratio, instead of for their logs.
If {cmd:eform} is not specified, then confidence intervals for the logs are displayed.
In either case, {cmd:punaf} also displays a confidence interval
for the population attributable fraction (PAF).

{phang}
{opt level(#)} specifies the percentage confidence level to be used in calculating the confidence intervals.
If it is not specified, then it is taken from the current value of the {help creturn:c-class value}
{cmd:c(level)},
which is usually 95.

{phang}
{opt post} specifies that {cmd:punaf} will post in {cmd:e()}
the {help estimates:estimation results}
for estimating the logs of the scenario means and of their ratio, the PUF.
If {cmd:post} is not specified, then any existing estimation results are left in {cmd:e()}.
Note that the estimation results posted are for the logs of the scenario means and of their ratio (the PUF),
whether or not {cmd:eform} is specified.


{title:Remarks}

{pstd}
{cmd:punaf} essentially implements the method for estimating population attributable fractions (PAFs)
recommended by {help punaf##greenland_1993:Greenland and Drescher (1993)} for cohort and cross-sectional studies.
This source recommended the use of the Normalizing and variance-stabilizing transformation

{pstd}
{cmd:log(PUF) = log(1-PAF)}

{pstd}
to define confidence intervals for the PAF.
{cmd:punaf} starts by estimating the logs of the scenario means and of their ratio (the PUF),
using {helpb margins} and {helpb nlcom}.
The results of this estimation are stored in {cmd:e()},
if the option {cmd:post} is specified.
These estimation results may be saved in an output dataset (or resultsset) by the {helpb parmest} package,
which can be downloaded from {help ssc:SSC}.

{pstd}
{cmd:punaf} assumes that the most recent {help estimates:estimation command}
estimates the parameters of a regression model,
whose {help predict:fitted values} are conditional arithmetic mean outcomes,
which must be positive.
It is the user's responsibility to ensure that this is the case.
However, it will be true if the conditional means are defined using a {help glm:generalized linear model}
with a log, logit, probit or complementary log-log link function.

{pstd}
{cmd:punaf} is intended to replace some of the functions of the {helpb aflogit} package
({help punaf##brady_1998:Brady, 1998}).
{helpb aflogit} was written in {help version:Version 6 of Stata},
and therefore will not work if the user uses long variable names and factor variables,
which were introduced in later {help version:Stata versions}.

{pstd}
Note that {cmd:punaf} (unlike {helpb aflogit}) does not implement the formulas
for estimating PAFs in case-control studies.
The logs of PUFs in case-control studies represent a different kind of parameter
from the logs of PUFs in cohort and cross-sectional studies,
but they are also estimable using {helpb margins} and {helpb nlcom}.


{title:Examples}

{pstd}
The following examples use the dataset {helpb datasets:lbw.dta},
provided by {help punaf##hosmer_1988:Hosmer and Lemeshow (1988)} and used in {manlink R logistic}
and distributed by {browse "http://www.stata-press.com/":Stata Press}.
This dataset has 1 observation for each of a sample of pregnancies,
and data on the birth weight of the baby
and on a list of predictive variables,
which might be assumed to be causal by some scientists.

{pstd}
Setup

{phang2}{cmd:.use http://www.stata-press.com/data/r11/lbw.dta, clear}{p_end}
{phang2}{cmd:.describe}{p_end}

{pstd}
The following example estimates population unattributable and attributable fractions
for maternal smoking during pregnancy as a predictor of low birth weight.
This is done by comparing "Scenario 1" (a fantasy world in which no pregnant women smoke)
with "Scenario 0" (the real world in which the data were collected).

{phang2}{cmd:. logit low i.race i.smoke, or robust}{p_end}
{phang2}{cmd:. punaf, at(smoke=0) eform}{p_end}

{pstd}
The following example estimates population unattributable and attributable fractions
for maternal smoking and non-white race.
This is done by comparing "Scenario 1" (a fantasy world in which all pregnant women are white and no pregnant women smoke)
with "Scenario 0" (the real world in which the data were collected).

{phang2}{cmd:.logit low i.race i.smoke, or robust}{p_end}
{phang2}{cmd:.punaf, at(smoke=0 race=1) eform}{p_end}

{pstd}
The following example demonstrates the use of {cmd:punaf}
with a univariate model of low birth weight with respect to maternal smoking status,
to estimate the total and exposed PAFs output by {helpb cs}.
We start by calling {helpb cs}
to calculate the total and exposed attributable fractions.
We then use {helpb logit} to estimate the odds ratio of low birth weight
with respect to maternal smoking,
and use {cmd:punaf} to estimate the scenario means and PAFs,
first for the total population,
and then for the smoking-exposed subpopulation.

{phang2}{cmd:.cs low smoke}{p_end}
{phang2}{cmd:.logit low i.smoke, or robust}{p_end}
{phang2}{cmd:.punaf, eform at(smoke=0)}{p_end}
{phang2}{cmd:.punaf if smoke==1, eform  at(smoke=0)}{p_end}

{pstd}
The following example demonstrates the use of {cmd:punaf}
with the {helpb parmest} and {helpb creplace} packages,
downloadable from {help ssc:SSC}.
The population unattributable and attributable fractions for smoking
are estimated using {cmd:punaf} (with the {cmd:post} option),
and saved, using {helpb parmest},
in a dataset in memory,
overwriting the original dataset,
with 1 observation for each of the 3 original parameters,
named {cmd:"Scenario_1"}, {cmd:"Scenario_2"} and {cmd:"PUF"},
and data on the estimates, confidence limits, {it:P}-values,
and other parameter attributes.
We then use {helpb replace} and {helpb creplace}
to replace the confidence interval for the PUF
with a confidence interval for the PAF,
and {helpb describe} and {helpb list} the new dataset.

{phang2}{cmd:. logit low i.race i.smoke, or robust}{p_end}
{phang2}{cmd:. punaf, at(smoke=0) eform post}{p_end}
{phang2}{cmd:. parmest, eform norestore}{p_end}
{phang2}{cmd:. foreach Y of var estimate min* max* {c -(}}{p_end}
{phang2}{cmd:. replace `Y'=1-`Y' if parm=="PUF"}{p_end}
{phang2}{cmd:. {c )-}}{p_end}
{phang2}{cmd:. creplace min* max* if parm=="PUF"}{p_end}
{phang2}{cmd:. replace parm="PAF" if parm=="PUF"}{p_end}
{phang2}{cmd:. describe}{p_end}
{phang2}{cmd:. list}{p_end}


{title:Saved results}

{pstd}
{cmd:punaf} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(rank)}}rank of {cmd:r(V)}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(N_sub)}}subpopulation observations{p_end}
{synopt:{cmd:r(N_clust)}}number of clusters{p_end}
{synopt:{cmd:r(N_psu)}}number of samples PSUs, survey data only{p_end}
{synopt:{cmd:r(N_strata)}}number of strata, survey data only{p_end}
{synopt:{cmd:r(df_r)}}variance degrees of freedom, survey data only{p_end}
{synopt:{cmd:r(N_poststrata)}}number of post strata, survey data only{p_end}
{synopt:{cmd:r(k_margins)}}number of terms in {it:marginlist}{p_end}
{synopt:{cmd:r(k_by)}}number of subpopulations{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(cimat)}}vector containing estimates and confidence limits for the PAF{p_end}
{synopt:{cmd:r(b)}}vector of logs of scenario means and their ratio{p_end}
{synopt:{cmd:r(V)}}estimated variance-covariance matrix of the logs of scenario means and their ratio{p_end}

{pstd}
If {cmd:post} is specified, {cmd:punaf} also saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_sub)}}subpopulation observations{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(N_psu)}}number of samples PSUs, survey data only{p_end}
{synopt:{cmd:e(N_strata)}}number of strata, survey data only{p_end}
{synopt:{cmd:e(df_r)}}variance degrees of freedom, survey data only{p_end}
{synopt:{cmd:e(N_poststrata)}}number of post strata, survey data only{p_end}
{synopt:{cmd:e(k_margins)}}number of terms in {it:marginlist}{p_end}
{synopt:{cmd:e(k_by)}}number of subpopulations{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:punaf}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}vector of logs of scenario means and their ratio{p_end}
{synopt:{cmd:e(V)}}estimated variance-covariance matrix of the logs of scenario means and their ratio{p_end}
{synopt:{cmd:e(V_srs)}}simple-random-sampling-without-replacement (co)variance
hat V_srswor, if {cmd:svy}{p_end}
{synopt:{cmd:e(V_srswr)}}simple-random-sampling-with-replacement (co)variance
hat V_srswr, if {cmd:svy} and {cmd:fpc()}{p_end}
{synopt:{cmd:e(V_msp)}}misspecification (co)variance hat V_msp, if {cmd:svy}
and available{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{title:Author}

{pstd}
Roger Newson, National Heart and Lung Institute, Imperial College London, UK.{break}
Email: {browse "mailto:r.newson@imperial.ac.uk":r.newson@imperial.ac.uk}


{title:References}

{marker brady_1998}{...}
{phang}
Brady A.
1998.
sbe21: Adjusted population attributable fractions from logistic regression.
{it:Stata Technical Bulletin} {bf:STB-42}: 8-12.
Download from {browse "http://www.stata.com/products/stb/journals/stb42.html":the {it:Stata Technical Bulletin} website}.

{marker greenland_1993}{...}
{phang}
Greenland S. and K. Drescher.
1993.
Maximum likelihood estimation of the attributable fraction from logistic models.
{it:Biometrics} {bf:49}: 865-872.

{marker hosmer_1988}{...}
{phang}
Hosmer Jr., D. W., S. Lemeshow, and J. Klar.
1988.
Goodness-of-fit testing for the logistic regression model when
the estimated probabilities are small.
{it:Biometrical Journal} {bf:30}: 911�924.


{title:Also see}

{psee}
Manual:  {manlink R margins}, {manlink R nlcom}, {manlink R logistic}, {manlink R logit}, {manlink R poisson}, {manlink R glm}
{p_end}

{psee}
{space 2}Help:  {manhelp margins R}, {manhelp nlcom R}, {manhelp logistic R}, {manhelp logit R}, {manhelp poisson R}, {manhelp glm R}{break}
{helpb parmest}, {helpb creplace}, {helpb aflogit} if installed
{p_end}
