#delim ;
program define marglmean_p;
version 13.0;
/*
 Predict program for marglmean
 (warning the user that predict should not be used
 after marglmean)
*! Author: Roger Newson
*! Date: 24 September 2013
*/

syntax [newvarlist] [, *];

disp as error
 "predict should not be used after marglmean";
error 498;

end;
