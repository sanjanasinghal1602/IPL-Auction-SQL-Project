select * from IPL_Ball;
select * from IPL_matches;

--Get the count of cities that have hosted an IPL match.
select count(distinct city) from IPL_matches;

--Create table deliveries_v02 with all the columns of the table deliveries and an additional column ball_result containing values boundary, dot, or other depending on total_run.
--total_run >= 4 → boundary
--total_run = 0 → dot
--Otherwise → other
create table deliveries_v02 as
select*,
       Case
	       When total_runs >= 4 then 'boundary'
		   When total_runs = 0 then 'dot'
		   else 'other'
		end as ball_result
from IPL_ball;

select * from deliveries_v02;

--Write a query to fetch the total number of boundaries and dot balls from the deliveries_v02 table.
select ball_result, count(ball_result)
from deliveries_v02
where ball_result in ('boundary', 'dot')
group by ball_result;

--Write a query to fetch the total number of boundaries scored by each team from the deliveries_v02 table
--and order it in descending order of the number of boundaries scored.
select batting_team, count(ball_result) as total_no_of_boundaries
from deliveries_v02
where ball_result = 'boundary'
group by batting_team
order by total_no_of_boundaries desc;


--Write a query to fetch the total number of dot balls bowled by each team and order it in descending order of the total number of dot balls bowled.
select bowling_team, count(ball_result) as total_no_of_dot
from deliveries_v02
where ball_result = 'dot'
group by bowling_team
order by total_no_of_dot desc;

--Write a query to fetch the total number of dismissals by dismissal kinds where dismissal kind is not NA.
select dismissal_kind, count(dismissal_kind) 
from IPL_ball
where dismissal_kind <> 'NA'
group by dismissal_kind;


--Write a query to get the top 5 bowlers who conceded maximum extra runs from the deliveries table.
select bowler, sum(extra_runs) as total_extra_run
from deliveries_v02
group by bowler
order by total_extra_run desc
limit 5;

--Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table and 
--two additional columns named venue and match_date from venue and date from table matches

create table deliveries_v03 as 
select d_2.*, m.venue, m.date as match_date
from deliveries_v02 as d_2
join IPL_matches as m
on d_2.id = m.id;

select * from deliveries_v03;


--Write a query to fetch the total runs scored for each venue and order it in the descending order of total runs scored.
select * from IPL_Ball;
select * from IPL_matches;

select m.venue, sum(b.total_runs) as total_run
from IPL_Ball as b
left join IPL_matches as m
on b.id = m.id
group by m.venue
order by total_run desc;

--Write a query to fetch the year-wise total runs scored at Eden Gardens and order it in the descending order of total runs scored.
select sum(b.total_runs) as total_runs, extract(Year from To_Date(m.date, 'DD-MM-YYYY')) as Years
from IPL_Ball as b
inner join IPL_matches as m
on b.id = m.id
where venue = 'Eden Gardens'
group by Years
order by total_runs desc;








