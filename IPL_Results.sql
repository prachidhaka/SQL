Use IPL_2024
/*
This is done on the basis of live data
*/

select * from IPL_2024

select Top 25 * from IPL_2024

/* Wins by home and away teams */

select top 10 * from IPL_2024
order by match_number

---how many times home_team and away team is won so far?
---and which one have better records of winning ?  
SELECT 
    SUM(CASE WHEN home_team = winner THEN 1 ELSE 0 END) AS home_winner,
    SUM(CASE WHEN away_team = winner THEN 1 ELSE 0 END) AS away_winner 
FROM  
    IPL_2024;

/*So here we can say home_team have better record  */

---Here we calculate points table  of each team how many games they have played. 
---how many wins how many losses ?

---1. we gona see here the places where the home team were the winner ?
--- and then the same for away_team 
---and then together we combine and try to make a points table

/*Point table */

With final as (
		select 
		match_number,home_team as team ,
		CASE WHEN home_team = winner THEN 2 ELSE 0 END as points 
		from IPL_2024
		
		union all
		
		select 
		match_number,away_team as team ,
		CASE WHEN away_team = winner THEN 2 ELSE 0 END as points 
		from IPL_2024
		)
Select * from final

/* now we do ordering */

With final as (
		select 
		match_number,home_team as team ,
		CASE WHEN home_team = winner THEN 2 ELSE 0 END as points 
		from IPL_2024
		
		union all
		
		select 
		match_number,away_team as team ,
		CASE WHEN away_team = winner THEN 2 ELSE 0 END as points 
		from IPL_2024
		)
Select team,count(*) as matches ,
sum(CASE WHEN points = 2 THEN 2 ELSE 0 END ) as Wins ,
---i have to count the no. losses 
sum(CASE WHEN points = 0 THEN 2 ELSE 0 END ) as Loss ,
Sum(points ) as full_points 

from final
group by final.team
order by full_points desc
