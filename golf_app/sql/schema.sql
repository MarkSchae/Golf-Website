-- scratch query file
-- database connection pending

create schema public;

create table players (
player_id serial primary key,
player_name varchar(100),
player_age int,
player_gender char(1),
fitted_clubs boolean, 
age_started_golf int, 
practice_sessions_week int, 
rounds_played_week int);

create table rounds (
round_id serial primary key,
player_id int,
constraint fk_player foreign key (player_id) references players(player_id),
course_id int,
    tee_played VARCHAR(50),
    max_carry_driver_m INT,
    fairways_hit INT,
    score INT,
    gir INT,
    putts INT,
    birdies INT,
    pars INT,
    date_played DATE);

create table courses (
course_id serial primary key,
course_name varchar (100),
course_difficulty_rating int,
course_par_score int, 
    course_black_yardage_m INT,
    course_white_yardage_m INT,
    course_blue_yardage_m INT,
    course_red_yardage_m INT,
    course_record INT);

alter table rounds
add constraint fk_course foreign key (course_id) references courses(course_id);

alter table players
rename rounds_played_week to rounds_played_year;

truncate courses restart identity;