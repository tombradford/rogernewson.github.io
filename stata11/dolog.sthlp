{smcl}
{.-}
help for {cmd:dolog} {right:(Roger Newson)}
{.-}
 
{title:Execute commands from a do-file, creating a log file}

{p 8 27}
{cmd:dolog} {it:filename}  [ {it:arguments} ]


{title:Description}

{p}
{cmd:dolog} (like {helpb do}) causes Stata to execute the commands stored in
{it:filename}{hi:.do} as if they were entered from the keyboard,
and echos the commands as it executes them, creating a {help log:text log file}
{it:filename}{hi:.log}.  If {it:filename} is specified
without an extension, filename.do is assumed. If {it:filename} is specified
with an extension, then the log file will have {hi:.log} as an additional
extension (so {cmd:dolog} will not overwrite the original do-file).
Arguments are allowed (as with {helpb do} or {helpb run}), but the
{cmd:nostop} option is not available.


{title:Remarks}

{p}
The original version of {cmd:dolog} was apparently an example given as {cmd:dofile}
in a Stata NetCourse. This version is slightly improved.

{p}
Note that a {help do:do-file} should nearly always start with a {helpb version} statement
at or near the top. This is because, nearly always, we prefer the do-file to run
in the {help version:Stata version} in which it was written, even if the version of Stata
has been upgraded. This practice also ensures that, if the do-file is run using {cmd:dolog},
then it is run under its own Stata version, and not under the Stata version of the current
version of {cmd:dolog}.

{p}
An exception to this rule occurs when the do-file is a
{help cscript:certification script}. For these, it is better to use the
{helpb dologx} package instead of {cmd: dolog}. To find unofficial Stata packages
which you might want to download, use {helpb net:net search} or {helpb findit}.


{title:Examples}

{p 8 16}{inp:. dolog trash1}{p_end}

{p 8 16}{inp:. dolog mycom argone argtwo}{p_end}


{title:Author}

{p}
Roger Newson, Imperial College London, UK.
Email: {browse "mailto:r.newson@imperial.ac.uk":r.newson@imperial.ac.uk}


{title:Also see}

{psee}
Manual:  {manlink R do}, {manlink R doedit}, {manlink R log}, {manlink P version}
{p_end}

{psee}
{space 2}Help:  {manhelp do R}, {manhelp run R}, {manhelp doedit R}, {manhelp log R}, {manhelp version P}, {manhelp cscript P};
{break}
{helpb dologx} if installed
{p_end}
