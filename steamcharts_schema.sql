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