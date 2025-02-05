#delim ;
prog def explist,rclass;
version 7.0;
/*
 Take, as input, a list of numbers,
 and create, as output, a new list of numbers of the same length,
 equal to an exponentiated version of the input list.
 Author: Roger Newson
 Date: 29 November 2001
*/

* Get the list of numbers *;
gettoken list 0 : 0, parse(",");
if "`list'" == "" | "`list'" == "," {; 
  di as error "no list specified";
  exit 198;
};
numlist "`list'";                       
local list "`r(numlist)'";
local nnum : word count `list';

* Get the options *;
syntax [ , Base(real 10) Scale(real 1) Global(string) Noisily ];

/*
  -base- is the base of the logarithmic list.
  -scale- is a scale factor for the new list.
  -global- is the name of a global variable to store the new list.
  -noisily- specifies that the new list must be printed.
  Each number in the new list is equal to scale*base^Z,
  where Z is the corresponding number in the input list.
*/

* Create exponentiated list *;
local explist "";
forv i1=1(1)`nnum' {;
  local Z:word `i1' of `list';
  local expcur=`scale'*`base'^`Z';
  if "`explist'"=="" {;local explist "`expcur'";};
  else {;local explist "`explist' `expcur'";};
};

* Return results, printing and globalising if requested *;
return local explist "`explist'";
if "`global'"!="" {;global `global' "`explist'";};
if "`noisily'"!="" {;disp as result "`explist'";};

end;
