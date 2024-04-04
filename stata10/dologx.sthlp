{smcl}
{.-}
help for {cmd:dolog{it:x}} {right:(Roger Newson)}
{.-}
 
{title:Multiple versions of {helpb dolog} for executing {help cscript:certification scripts}}

{p 8 27}
{cmd:dolog6} {it:filename}  [ {it:arguments} ]

{p 8 27}
{cmd:dolog7} {it:filename}  [ {it:arguments} ]

{p 8 27}
{cmd:dolog8} {it:filename}  [ {it:arguments} ]

{p 8 27}
{cmd:dolog9} {it:filename}  [ {it:arguments} ]

{p 8 27}
{cmd:dolog10} {it:filename}  [ {it:arguments} ]


{title:Description}

{p}
The programs {cmd:dolog{it:x}} are versions of the program {helpb dolog},
each of which attempts to execute a {help do:do-file}
under the appropriate {help version:Stata  version} {it:x}.
{helpb dolog} is downloadable from {help ssc:SSC}.
Like {helpb do}, it causes Stata to execute the commands stored in
a file {it:filename}{hi:.do}, echos the commands as it
executes them, and creates a text {help log:log file} {it:filename}{hi:.log}.
The program {cmd:dolog{it:x}} executes the do-file in Stata version {it:x},
unless the user includes a {helpb version} statement in the do-file.
Usually, a do-file should always contain a {helpb version} statement at or near the top,
and then it will be executed by {helpb dolog} (or {cmd:dolog{it:x}} or {helpb do} or {helpb run}) in
the version of Stata in which it was written. However, some do-files, such as
{help cscript:certification scripts}, should not contain a {helpb version} statement,
because it is important to prove that they execute correctly under multiple versions
of Stata (Gould, 2001).


{title:Remarks}

{p}
The {cmd:dolog{it:x}} package is distributed separately from the {helpb dolog} package.
This is because the {cmd:dolog{it:x}} package is intended for use by advanced
programmers (eg programmers who write {help cscript:certification scripts}),
and such advanced programmers will often have access to two
{help version:versions} of Stata at the same time while in transition
from one version to another, and will therefore probably want to update
their versions of {cmd:dolog{it:x}} immediately when they start to have access to
the new version of Stata, and to update their versions of {helpb dolog} later,
when the transition is complete. Note that, if the user includes a {helpb version}
command at the top of a {help do:do-file}, then it does not matter
whether  the user uses {helpb dolog} or {cmd:dolog{it:x}}, because
Stata will then execute the do-file in the version of Stata indicated at the top
of the do-file, as long as that version, and the version of {helpb dolog} or {cmd:dolog{it:x}},
are no higher than the version of the Stata executable being used.


{title:Examples}

{p}
The following examples execute a certification script {hi:parmest.do} in Stata 7 and Stata 8, respectively,
each time creating a text log file {hi:parmest.log}. This is done to prove that
the examples in {hi:parmest.do} work under both Stata versions.

{p 8 16}{inp:. dolog7 parmest}{p_end}

{p 8 16}{inp:. dolog8 parmest}{p_end}


{title:Author}

{p}
Roger Newson, Imperial College London, UK.
Email: {browse "mailto:r.newson@imperial.ac.uk":r.newson@imperial.ac.uk}


{title:References}

{p}Gould, W.  2001.  Statistical software certification.
{it:The Stata Journal} 1: 29-50.


{title:Also see}

{p 0 21}
{bind: }Manual:  {hi:[R] do}, {hi:[R] log}
{p_end}
{p 0 21}
On-line:  help for {helpb do}, {helpb run}, {helpb doedit}, {helpb log}, {helpb version}, {helpb cscript}
{p_end}
{p 10 21}
help for {helpb dolog} if installed
{p_end}
