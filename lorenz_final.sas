proc contents data=work.olo;
run;

proc sort data=work.olo out=sorted;
	by default descending score_comb;
run;


data Sorted;
set Sorted;
defaultsum+default;
run;



proc summary data=Sorted nway missing;
output out=SortedStats
sum(default) = defaultNumber;
var default;
run;
data SortedStats;
set SortedStats;
num = _FREQ_;
keep num defaultNumber;
run;


proc sql;
create table base as
select A.defaultsum, B.defaultNumber, B.num
	from Sorted as A,Sortedstats as B;
quit;

data Base;
set Base;
per = (defaultsum/defaultNumber*100);
run;
