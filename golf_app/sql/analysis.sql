-- scratch query file
-- database connection pending

select player_name from players
select player_name, count(*) from players
select player_name from players
select player_name from players
select player_name from players
select player_name from players
select players.player_name, count(players.player_name) as count from players
select players.player_name, count(rounds.round_id) as count from players
select players.player_name, count(rounds.round_id) as rounds_played from players
select players.player_name, count(rounds.round_id) as rounds_played from players
select players.player_name, count(rounds.round_id) as rounds_played from players
select players.player_name, count(rounds.round_id) as rounds_played from players
select players.player_name, count(rounds.round_id) as rounds_played from players
select p.player_name, avg(r.score) as average score from players p
select * from rounds
select * from rounds
select * from rounds
select players.player_name, courses.course_name, rounds.score, courses.course_par_score from rounds
select players.player_name, courses.course_name, rounds.score, courses.course_par_score from rounds
select players.player_name, count(rounds.round_id) as total_rounds, courses.course_name, rounds.score, courses.course_par_score from rounds
select players.player_name, courses.course_name, rounds.score, courses.course_par_score, count(rounds.round_id) as total_rounds from rounds
select c.course_name, count(r.round_id) as number_of_rounds_played_here from courses c
select c.course_name, r.score, floor(r.score) from courses c
select c.course_name, r.score, floor(r.score) as lowest_score from courses c
select c.course_name, r.score, floor(r.score) as lowest_score from courses c
select c.course_name, floor(r.score) as lowest_score from courses c
select c.course_name, floor(r.score) as lowest_score from courses c
select c.course_name, floor(r.score) as lowest_score from courses c
select c.course_name, floor(r.score) as lowest_score from courses c
select c.course_name, floor(r.score) as lowest_score from courses c
select c.course_name, r.score, min(r.score) as lowest_score from courses c
select c.course_name, r.score, min(r.score) as lowest_score from courses c
select p.player_name, min(r.score) from players p
select p.player_name, c.course_name, min(r.score) from players p
select p.player_name, c.course_name, min(r.score) from players p
select p.player_name, c.course_name, min(r.score) as best_score from players p
select p.player_name, c.course_name, min(r.score) as best_score from players p
select c.course_name, p.player_name, min(r.score) as best_score from players p
select p.player_name, c.course_name, r.date_played from players p
select p.player_name, c.course_name, r.date_played from players p
select p.player_name, c.course_name, r.date_played from players p
select p.player_name, c.course_name, r.date_played, min(r.score) from players p
select max(p.player_name) as player, c.course_name, r.date_played, min(r.score) as best_score from players p
select max(p.player_name) as player, c.course_name, r.date_played, min(r.score) as best_score from players p
select max(p.player_name) as player, c.course_name, r.date_played, min(r.score) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) as best_score over (partition by p.player_name) from players p
select p.player_name, c.course_name, r.date_played, min(r.score) over (partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) over (partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) over (partition by p.player_name group by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) over (partition by p.player_name group by best_score) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) row_number over (partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) row_number() over (partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) row_number() over(partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score), row_number() over(partition by p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score), row_number() over(partition by p.player_name order by r.date_played) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score), row_number() over(group by p.player_name order by r.date_played) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score), row_number() over(partition by p.player_name order by r.date_played) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) OVER(PARTITION BY best_score) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) OVER(PARTITION BY p.player_name, order by best_score) as best_score from players p
select distinct on(p.player_name) p.player_name, c.course_name, r.date_played, min(r.score) OVER(PARTITION BY p.player_name order by best_score) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) OVER(PARTITION BY p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) OVER(PARTITION BY p.player_name) as best_score from players p
select p.player_name, c.course_name, r.date_played, min(r.score) 
select p.player_name, c.course_name, r.date_played, min(r.score) as best_score
select p.player_name, c.course_name, r.date_played, min(r.score)
select p.player_name, c.course_name, r.date_played, min(r.score)
select p.player_name, c.course_name, r.date_played, min(r.score)
select p.player_name, c.course_name, r.date_played, min(r.score)
select p.player_name, c.course_name, r.date_played, r.score,
select p.player_name, c.course_name, r.date_played, r.score,
select p.player_name, c.course_name, r.date_played, r.score,
select p.player_name from players p
select p.player_name, c.course_name, min(r.score) from players p
select p.player_name, c.course_name, min(r.score) from players p
select p.player_name, c.course_name, from players p
select p.player_name, c.course_name, r.score, min(r.score) as best,
select p.player_name, c.course_name, r.score, 
with leaderboard as (
with leaderboard as (
with leaderboard as (
with leaderboard as (
with leaderboard as (
with leaderboard as (
with leaderboard as (
with leaderboard as (
select p.player_name, r.score, c.course_name from rounds r
select p.player_name, r.score, c.course_name from rounds r
select p.player_name, r.score, c.course_name
select p.player_name, r.score, c.course_name,
select p.player_name, r.score, c.course_name,
select p.player_name, r.score, c.course_name,
select p.player_name, c.course_name,
select p.player_name, c.course_name,
with course_leaderboard as (
with course_leaderboard as (
with course_leaderboard as (
with course_leaderboard as (
with course_leaderboard as (
with course_leaderboard as (
select p.player_name over(partition by p.player_name), r.date_played, r.score,
select p.player_name over (partition by p.player_name), r.date_played, r.score,
from rounds r
select p.player_name, r.date_played, r.score,
select p.player_name, r.date_played, r.score,
desc
select p.player_name, r.date_played, r.score,
create table stagingStats (
create table stagingStats (
create table stagingStats (
create table stagingStats (
alter table stagingstats 
alter table stagingstats s
alter table stagingstats s
alter table stagingstats
SELECT s.* FROM golf.stagingstats AS s
select distinct player_name from stagingstats 
select distinct player_name from stagingstats 
select distinct stagingstats.player_name as s, players.player_name as p from stagingstats 
select distinct stagingstats.player_name as s, players.player_name as p from stagingstats 
select distinct stagingstats.player_name as s, players.player_name as p from stagingstats 
select round_id, score from rounds
select rounds.round_id, rounds.score from rounds
select rounds.round_id, rounds.score from rounds
select rounds.score as rs, stagingstats.score as ss from rounds
select rounds.score as rs, stagingstats.score as ss from rounds
select tee_played, max_carry_driver_m, fairways_hit, score, gir, putts, birdies, pars, date_played, player_name, course_name, course_difficulty_rating from stagingstats
insert into rounds (tee_played, max_carry_driver_m, fairways_hit, score, gir, putts, birdies, pars, date_played, player_name, course_name, course_difficulty_rating)
r.score AS main_score,
SELECT
select * from rounds
golf.rounds
select * from golf;
select p.player_name, p.player_age, p.player_gender, p.fitted_clubs, p.age_started_golf, p.practice_sessions_week, p.rounds_played_year, avg(score)
select p.player_name, p.player_age, p.player_gender, p.fitted_clubs, p.age_started_golf, p.practice_sessions_week, p.rounds_played_year, avg(r.score)
select p.player_name, p.player_age, p.player_gender, p.fitted_clubs, p.age_started_golf, p.practice_sessions_week, p.rounds_played_year, avg(r.score)
select p.player_name, avg(r.score)
select p.*, avg(r.score) as all_rounds_avg
select p.*, avg(r.score) as all_rounds_avg
select p.*, avg(r.score) as all_rounds_avg
select p.*, avg(r.score) as all_rounds_avg
select p.*, avg(r.score) as all_rounds_avg
select p.player_name, min(r.score) as best
SELECT * FROM pgagent.pga_job
