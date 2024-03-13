use ipl;


-- match table re-created
Create table match_data_f as
SELECT match_.Match_Id, Team1.Team_Name AS Team1_Name, Team2.Team_Name AS Team2_Name, match_.match_date, match_.Season_id, 
v.venue_name, ct.city_name, co.country_name, p.team_name as toss_winner,t.toss_name as toss_decide, w.win_type as win_type, match_.win_margin, 
o.outcome_type as outcome_type, d.team_name as match_winner, c.player_name as man_of_the_match
FROM match_
JOIN team AS Team1 ON match_.Team_1 = Team1.Team_Id
JOIN team AS Team2 ON match_.Team_2 = Team2.Team_Id
join player c
on match_.man_of_the_match = c.player_id
join team d
on match_.match_winner = d.team_Id
join outcome o 
on match_.outcome_type = o.outcome_id
join win_by w
on match_.win_type = w.win_id
join toss_decision t
on match_.toss_decide = t.toss_id
join venue v
on match_.venue_id = v.venue_id
join city ct
on v.city_id = ct.city_id
join country co
on ct.country_id = co.country_id
join team p
on match_.toss_winner = p.team_id
order by match_id;

-- player table re-created
-- Create table player_table_f as
select a.player_id, a.player_name, a.DOB, b.batting_hand, c.bowling_skill, d.country_name
from player a
join batting_style b
on a.batting_hand = b.batting_id
left join bowling_style c
on a.Bowling_skill = c.Bowling_Id
join country d
on a.Country_Name = d.Country_Id
order by Player_Id;

-- wicket-taken table recreate
Create table wicket_table_f as 
select a.match_id, a.Innings_No, a.over_id, a.ball_id, c.player_name as  batsman, d.player_name as bowler, e.out_name, 
f.player_name as fielder
from wicket_taken a
left JOIN ball_by_ball b 
ON a.match_Id = b.match_Id
and a.over_id = b.over_id
and a.ball_id = b.ball_id
and a.innings_No = b.Innings_no
left join player c
on a.player_out = c.player_id
join player d
on b.bowler = d.player_id 
left join out_type e
on a.Kind_Out = e.Out_Id
left join player f 
on a.Fielders = f.Player_Id
order by match_id, Innings_No, over_id, Ball_Id;

-- CREATE TABLE bowling_style_player_fi AS
SELECT b.Bowling_Id, a.Bowling_skill AS Player_Bowling_Skill, a.Player_Id, a.Player_Name, a.Batting_hand, 
b.Bowling_skill AS Bowling_Style, a.Country_Name 
FROM player a 
left JOIN bowling_style b ON a.bowling_skill = b.bowling_id 
ORDER BY a.Player_Id;

create table ball_by_ball_f as
select a.match_id, a.innings_No, a.over_id, a.ball_id, b.team_name as team_batting, c.team_name as team_bowling, a.striker_batting_position,
d.player_name as striker, e.player_name as non_striker, f.player_name as bowler_name, g.runs_scored
from ball_by_ball a
join team b
on a.team_batting = b.team_id
join team c
on a.team_bowling = c.team_id
join player d
on a.striker = d.player_id
join player e
on a.non_striker = e.player_id
join player f
on a.bowler = f.player_id
left join batsman_scored g
ON a.match_Id = g.match_Id
and a.over_id = g.over_id
and a.ball_id = g.ball_id
and a.innings_No = g.Innings_no
order by match_id, innings_no, over_id, ball_id;
