-- scratch query file
-- database connection pending

SELECT * FROM users
CREATE TABLE users (
select name from users where name = Alice
select age from users where name = Alice
select * from users where name = Alice
select * from users where name = Alice
select * from users where name = alice
select name from users where name = Alice
select name from users where name = Alice
select name from users where name = Alice
select * from users where name is like 'ice'
CREATE TABLE events (
(5, 'login', '2024-02-07 20:00'),
(5, 'login', '2024-02-07 20:00'),
.schema
select * from information_schema
select * from schema
select * from schema
select * from schema
select * from schemas
.schemas
.Schemas
select * from information_schema
select * from users u sessions u events
select * from users u, sessions, u events
select * from users u, sessions u, events
select * from users, sessions s, events e limit 5 rows
select * from users, sessions s, events e, limit 5 rows
select * from users, sessions s, events e, limit 5
select * from users, sessions s, events e, limit 5
select * from users, sessions s, events e, limit
select * from users, sessions s, events e limit 5 count(*)
select * from users, sessions s, events e limit 5, count(*)
select * from users, sessions s, events e limit 5, count(5)
select * from events where created_at > '2024-02-03' and < '2024-02-07'
select * from users join sessions s
select * from users join sessions
select * from users join events
select * from users join events on user.id = event.id
select * from users join sessions on session.user_id = user.id
select * from sessions join users on session.user_id = user.id
select username from users join users on users.id = events.session_id
select username from users distinct join events on users.id = events.session_id
select username from users join events on users.id = events.session_id, distinct
select username from users join events on users.id = events.session_id distinct
select distinct t username from users join events on users.id = events.session_id
select distinct username from users join sessions on sessions.user_id = users.id join events where event_type is not null
select * from sessions join events on sessions.id = events.session_id where event_type is not 'logout'
select *, count(*) over() as total_count from events where created_at = '2024'
select *, count(*) over() as total_count from events where created_at like '2024'
select *, count(*) over() as total_count from events where events.created_at like '2024'
select *, count(*) over() as total_count from events where events.created_at like '2024'
select *, count(*) over() as total_count from events where created_at like '2024-02-03'
select *, count(*) over() as total_count from events where created_at like '%2024%'
select *, count(*) over() as total_count from events where created_at '%2024%'
select *, count(*) over() as total_count from events where created_at = '%2024%'
select *, count(*) over() as total_count from events where created_at like '%2024%'
select *, count(*) over() as total_count from events where created_at like %2024%
select *, count(*) over() as total_count from events where created_at >= '2024-01-01' and < '2025-01-01'
select *, count(event_type) from events where events.id = session_id
select distinct session_id, count(distinct event_type) over() as event_per from events where events.
select distinct session_id, count(distinct event_type) over() as event_per from events
select distinct session_id, count(distinct event_type) over() as event_per from events
select distinct session_id, count(distinct event_type) over() as event_per from events group by session_id
select distinct session_id, count(event_type) over() as event_per from events group by session_id
select distinct session_id, count(events.event_type) over() as event_per from events group by session_id
select distinct session_id, count(event_type) over() as event_per from events group by events.session_id
select distinct session_id, count(event_type) over() as event_per from events group by event_type 
select distinct session_id, count(event_type) over() as event_per from events group by events.event_type
select distinct session_id, count(event_type) over() as event_per from events group by events.event_type
select distinct session_id, count(event_type) over() as event_per from events join sessions on sessions.id = events.session_id group by session_id
select * from events where events.id = sessions_id
select * from events where events.id = events.sessions_id
select * from events group by session_id
select * from events group by events.session_id
select * from events group by session_id
select event_type from events group by session_id
select count(event_type), session_id from events
select count(event_type), session_id from events
select count(event_type), session_id from events
group by session_id
select session_id, count(event_type) from events
select events.session_id, count(event_type) from events
select events.session_id, count(event_type) from events
select session_id, count(*) from events
select session_id, count(*) from events
select *, count(*) from events
select *, count(*) from events
select *, count(*) from events
select *, count(*) from events
select *, count(*) from events
select *, count(events.id) from events
select *, count(events.id) from events
select *, count(events.id) from events
select *, count(event_type ) from events
select *, count(event_type) from events
select *, count(event_type) from events
select *, count(event_type) from events
select *, count(*) from events
select *, count(*) from events
select * from users join sessions on sessions.id = users.id join events on event_type
select count(id) from users join sessions on sessions.id = users.id join events on session_id = users.id
select count(id), username from users join sessions on sessions.id = users.id join events on session_id = users.id
select count(users.id), username from users join sessions on sessions.id = users.id join events on session_id = users.id
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username dec
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username order by desc
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username order by desc
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username desc
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username desc
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username desc
select count(username), username from users join sessions on sessions.id = users.id join events on session_id = users.id group by username desc
select *, count(event_type) over() as per_day from events group by created_at
select event_type, count(event_type) over() as per_day from events group by created_at
select created_at, count(event_type) over() as per_day from events group by created_at
select created_at, count(event_type) over() as per_day from events group by created_at
select created_at, count(event_type) over() as per_day from events group by created_at
select created_at, count(event_type) over() as per_day from events group by event_type
select created_at, count(event_type) over() as per_day from events group by event_type
select count(event_type), event_type from events
select count(event_type), event_type, created_at from events group by event_type order by count desc
select count(event_type), created_at, event_type from events group by event_type order by count desc
select count(event_type), created_at, event_type from events group by event_type order by count desc
select count(event_type), created_at, event_type from events group by created_at order by count desc
select count(event_type), created_at, event_type from events group by created_at event_type order by count desc
select count(event_type, created_at), event_type, created_at from events group by event_type, created_at order by count desc
select count(event_type, created_at), event_type, created_at from events group by event_type, created_at order by count desc
select avg(event_type), session_id from events group by session_id
count
count
select sum(event_type) from events
select sum(event_type) as total from events
select sum(event_type) as total from events
select sum(event_type) as total from events
select sum(event_type) as total from events
select sum(event_type) as total from events
select sum(event_type) as total from events
create schema public
SELECT e.* FROM public.events AS e
create table players (
truncate courses restart identity
delete * from courses c
delete * from courses
delete courses
DROP TABLE golf.courses
DROP TABLE golf.players
alter table courses drop course_difficulty_rating
alter table courses drop column course_difficulty_rating
alter table courses drop column course_difficulty_rating
alter table courses 
SELECT c.* FROM golf.courses AS c
SELECT c.* FROM golf.courses AS c
insert into courses course_name values testing
insert into courses (course_name) values testing
insert into courses (course_name) values "testing"
insert into courses (course_name) values (testing)
insert into courses (course_name) values (testing)
insert into courses (course_name) values ('testing')
update players
update players
update players
\dt