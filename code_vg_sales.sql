--View table
SELECT *
FROM vg_sales

--Deleting rank column
ALTER TABLE vg_sales
DROP COLUMN Rank;

--Renaming Name column
EXEC sp_RENAME 'vg_sales.Name', 'Game';

--Sales share on the markets
SELECT SUM(NA_Sales)/SUM(Global_Sales)*100 AS Per_Sales_NA,
	SUM(EU_Sales)/SUM(Global_Sales)*100 AS Per_Sales_EU,
	SUM(JP_Sales)/SUM(Global_Sales)*100 AS Per_Sales_JP,
	SUM(Other_Sales)/SUM(Global_Sales)*100 AS Per_Sales_Other
FROM vg_sales
--Game sales worldwide over the years
SELECT year, SUM(Global_Sales) AS Sales
FROM vg_sales
WHERE Year IS NOT NULL
GROUP BY Year
ORDER BY Sales DESC;

--Analysis of Genre category
	--Number of games released for each genre
SELECT Genre, COUNT('Genre') AS Number_Games
FROM vg_sales
GROUP BY Genre
ORDER BY Genre;


	--Number of sales by genre
WITH Total_GB AS
	(SELECT SUM(Global_Sales) AS Total_GB
	FROM vg_sales)
SELECT Genre, AVG(Global_Sales)*100 AS Avg_Sales_Thousand, SUM(Global_Sales)/Total_GB*100 AS Percentage
FROM vg_sales, Total_GB
GROUP BY Genre, Total_GB
ORDER BY Avg_Sales_Thousand DESC;
--ORDER BY Percentage DESC;

--Analysis of Platform category
	--Number of games released on each platform
SELECT Platform, COUNT(Platform) AS Game_Platform
FROM vg_sales
GROUP BY Platform
ORDER BY Game_Platform DESC;


	--Number of sales per platorm
WITH Total_Sales AS
	(SELECT SUM(Global_Sales) AS Total_Sales
	FROM vg_sales)
SELECT Platform,  AVG(Global_Sales)*100 AS Avg_Sales_Thousand, SUM(Global_Sales) / Total_Sales *100 AS Percentage
FROM vg_sales, Total_Sales
GROUP BY Platform, Total_Sales
ORDER BY Percentage DESC;
--ORDER BY Avg_Sales_Thousand DESC;


--Analysis of Games category

	--Number of games in the dataset
SELECT COUNT(Game)
FROM vg_sales
 
	--Number of sales percentage
WITH Total_Sales AS
	(SELECT SUM(Global_Sales) AS Total_Sales
	FROM vg_sales)
SELECT DISTINCT Game, Publisher, Global_Sales, SUM(Global_Sales) / Total_Sales *100 AS Percentage
FROM vg_sales, Total_Sales
GROUP BY Game, Total_Sales, Global_Sales, Publisher
ORDER BY Percentage DESC;



--Analysis of Publisher category

	--Number of game released by each publisher
SELECT Publisher, COUNT(Publisher) AS Game_Publisher
FROM vg_sales
GROUP BY Publisher
ORDER BY Game_Publisher  DESC;


	--Number of sales percentage
WITH Total_Sales AS
	(SELECT SUM(Global_Sales) AS Total_Sales
	FROM vg_sales)
SELECT Publisher, AVG(Global_Sales) AS Avg_Sales, SUM(Global_Sales) / Total_Sales *100 AS Percentage
FROM vg_sales, Total_Sales
GROUP BY Publisher, Total_Sales
ORDER BY Percentage DESC;


	--Nintendo's Success
SELECT Game, Year, Global_Sales
FROM vg_sales
WHERE Publisher = 'Nintendo' AND Year IS NOT NULL
GROUP BY Year, Game, Global_Sales
ORDER BY Global_Sales DESC, Game, Year; 

	--Electronic Arts' Success
SELECT Game, Year, Global_Sales
FROM vg_sales
WHERE Publisher = 'Electronic Arts' AND Year IS NOT NULL
GROUP BY Year, Game, Global_Sales
ORDER BY Global_Sales DESC, Game, Year; 

