CREATE DATABASE steamcharts_db;

CREATE TABLE IF NOT EXISTS steamcharts (
    month_str VARCHAR(10),    
    avg_players DECIMAL(12, 2),  
    gain DECIMAL(12, 2),
    gain_percent DECIMAL(10, 4),
    peak_players INT,
    name VARCHAR(255),
    steam_appid BIGINT,          
    game_month DATE         
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/steamcharts.csv'
INTO TABLE steamcharts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(month_str, avg_players, gain, gain_percent, peak_players, name, steam_appid, game_month);

USE steamcharts_db;

SHOW TABLES;

LOAD DATA LOCAL INFILE 'C:/Users/abdir/Desktop/SteamCharts Game Player Analysis (MySQL)/steamcharts.csv'
INTO TABLE steamcharts_db
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(month_str, avg_players, gain, gain_percent, peak_players, name, steam_appid, game_month);


SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';


SELECT COUNT(*) AS total_rows FROM steamcharts_db;

SELECT * FROM steamcharts_db LIMIT 10;

SELECT 
    SUM(month_str IS NULL) AS missing_month,
    SUM(avg_players IS NULL) AS missing_avg_players,
    SUM(gain IS NULL) AS missing_gain,
    SUM(gain_percent IS NULL) AS missing_gain_percent,
    SUM(peak_players IS NULL) AS missing_peak_players,
    SUM(name IS NULL) AS missing_name
FROM steamcharts_db;


SELECT name, ROUND(AVG(avg_players), 2) AS avg_players
FROM steamcharts_db
GROUP BY name
ORDER BY avg_players DESC
LIMIT 10;


SELECT name, MAX(peak_players) AS peak_players
FROM steamcharts_db
GROUP BY name
ORDER BY peak_players DESC
LIMIT 10;


SELECT game_month, avg_players, gain_percent
FROM steamcharts_db
WHERE name = 'Counter-Strike 2'
ORDER BY game_month;


SELECT YEAR(game_month) AS year, ROUND(AVG(gain_percent), 2) AS avg_gain_percent
FROM steamcharts_db
GROUP BY YEAR(game_month)
ORDER BY year;


CREATE VIEW game_summary AS
SELECT 
    name,
    ROUND(AVG(avg_players), 2) AS avg_players,
    ROUND(MAX(peak_players), 0) AS max_peak_players,
    ROUND(AVG(gain_percent), 2) AS avg_gain_percent
FROM steamcharts_db
GROUP BY name;


SHOW FULL TABLES WHERE table_type = 'VIEW';


SELECT * FROM game_summary ORDER BY avg_players DESC LIMIT 10;


SELECT * FROM game_summary WHERE name LIKE '%Dota%';



SELECT name, COUNT(*) AS months_positive
FROM steamcharts_db
WHERE gain_percent > 0
GROUP BY name
ORDER BY months_positive DESC
LIMIT 10;

SELECT name, ROUND(STD(gain_percent), 2) AS volatility
FROM steamcharts_db
GROUP BY name
ORDER BY volatility DESC
LIMIT 10;

SELECT YEAR(game_month) AS year, ROUND(AVG(avg_players), 2) AS avg_players
FROM steamcharts_db
GROUP BY YEAR(game_month)
ORDER BY year;
