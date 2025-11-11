# 🎮 SteamCharts Data Analysis (MySQL) <img src="https://github.com/user-attachments/assets/69136b29-fe5f-41eb-bdb6-263fe2378b2a" width="40px">

## 📘 Project Overview
This project explores player activity trends and performance metrics for games on Steam using the **SteamCharts dataset**.
Using **MySQL**, I cleaned, structured, and analyzed the dataset to uncover insights on player counts, growth patterns, and game popularity over time.

---

## 🧩 Objectives
- Import and clean raw CSV data into a MySQL database
- Perform SQL-based exploratory data analysis (EDA)
- Identify top-performing and most-volatile games
- Summarize trends in player growth and engagement

---
## Tools used💻
[![My Skills](https://skillicons.dev/icons?i=mysql,vscode)](https://skillicons.dev)

---
## 🗄️ Database Setup

**Database Name:** `steamcharts_db`  
**Main Table:** `steamcharts`

**Schema:**

| Column Name   | Data Type       | Description |
|----------------|----------------|--------------|
| month_str      | VARCHAR(10)    | Month name (string format) |
| avg_players    | DECIMAL(12,2)  | Average number of players in the month |
| gain           | DECIMAL(12,2)  | Change in player count from previous month |
| gain_percent   | DECIMAL(10,4)  | Percentage change in player count |
| peak_players   | INT            | Highest number of concurrent players |
| name           | VARCHAR(255)   | Game title |
| steam_appid    | BIGINT         | Unique Steam game ID |
| game_month     | DATE           | Year-month of record |

---

## 📥 Data Import Command

```sql
LOAD DATA LOCAL INFILE 'C:/Users/abdir/Desktop/steamcharts.csv'
INTO TABLE steamcharts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(month_str, avg_players, gain, gain_percent, peak_players, name, steam_appid, game_month);
```

---
## 🧠 Queries used

### 🔹 1. Top 10 Games by Average Players
```sql
SELECT name, ROUND(AVG(avg_players), 2) AS avg_players
FROM steamcharts
GROUP BY name
ORDER BY avg_players DESC
LIMIT 10;
```

### 🔹 2. Games with Highest Peak Players
```sql
SELECT name, MAX(peak_players) AS peak_players
FROM steamcharts
GROUP BY name
ORDER BY peak_players DESC
LIMIT 10;
```

### 🔹 3. Monthly Trend for a Specific Game
```sql
SELECT game_month, avg_players, gain_percent
FROM steamcharts
WHERE name = 'Counter-Strike 2'
ORDER BY game_month;
```

### 🔹 4. Yearly Average Gain Percent
```sql
SELECT YEAR(game_month) AS year, ROUND(AVG(gain_percent), 2) AS avg_gain_percent
FROM steamcharts
GROUP BY YEAR(game_month)
ORDER BY year;
```

---

## 📊 View Creation
To make reporting easier, a summary view was created:

```sql
CREATE OR REPLACE VIEW game_summary AS
SELECT 
    name,
    ROUND(AVG(avg_players), 2) AS avg_players,
    ROUND(MAX(peak_players), 0) AS max_peak_players,
    ROUND(AVG(gain_percent), 2) AS avg_gain_percent
FROM steamcharts
GROUP BY name;
```

---

## 🔍 Insights & Observations
- Some titles (like **Counter-Strike** and **Dota 2**) consistently lead in player averages and peaks.
- Games with frequent content updates often show higher positive gain percentages.
- Yearly averages reveal overall player growth trends across the Steam platform.

---

## 🛠️ Tools & Technologies
- **MySQL 8.0** (Data storage & analysis)
- **VS Code MySQL Extension**
- **SteamCharts dataset (CSV)**

---

## 📁 Project Structure

```
SteamCharts-Data-Analysis-MySQL/
│
├── steamcharts.csv
├── queries.sql
├── steamcharts_schema.sql
├── README.md
└── screenshots/
    ├── import_success.png
    ├── view_results.png
```

---

## 📈 Future Improvements
- Connect MySQL to **Power BI** for dynamic dashboards
- Add **Python visualization** (matplotlib/seaborn)
- Automate monthly updates using scheduled SQL jobs

---
📫 Connect with me on:  
- 💼 **LinkedIn:** [linkedin.com/in/abdirahman-ahmed-b7841a343](https://www.linkedin.com/in/abdirahman-ahmed-b7841a343)  
- 📧 **Email:** [abdirahmanahmed2728@email.com](mailto:abdirahmanahmed2728@email.com)  

---
⭐ **Author:** _Abdirahman Ahmed_  
🗓️ **Year:** 2025
