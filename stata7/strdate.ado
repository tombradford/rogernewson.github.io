#delim ;
prog def strdate;
version 7.0;
syntax varlist(string)[,S2(string asis) Ycutoff(string) Format(string)];
*
 Convert string date variables in varlist
 to numeric date variables with the same names and labels,
 occupying the same positions in the variable order,
 with format given by format.
 Conversion is done using the date function,
 with s2 as the s2 argument
 (a string containing a permutation of m, d and [##]y)
 and ycutoff as the year cutoff argument for 2-digit years.
 Author: Roger Newson
 Date: 23 July 2002.
*;

* Initialise local variables and default string options *;
local nvar:word count `varlist';
if(`"`s2'"'==""){local s2 `""dmy""';};
if(`"`ycutoff'"'==""){local ycutoff=0};
if(`"`format'"'==""){local format `"%dD_m_CY"';};
* Confirm that ycutoff is a valid numeric argument *;
capt confirm number `ycutoff';local ycncon=_rc==0;
capt confirm numeric variable `ycutoff';local ycnvar=_rc==0;
if(!(`ycncon'|`ycnvar')){
  disp as error "Invalid ycutoff()";
  error 498;
};

preserve;

* Replace members of varlist one by one *;
tempvar tmpdate;
local i1=0;
while(`i1'<`nvar'){local i1=`i1'+1;
  local date:word `i1' of `varlist';
  local datelab:variable label `date';
  if(`ycutoff'==0){qui gene `tmpdate'=date(`date',`s2');};
  else{qui gene `tmpdate'=date(`date',`s2',int(`ycutoff'));};
  qui compress `tmpdate';
  move `tmpdate' `date';drop `date';rename `tmpdate' `date';
  lab var `date' "`datelab'";
  format `date' `format';
};

restore,not;

end;
