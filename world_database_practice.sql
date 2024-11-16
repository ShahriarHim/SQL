
-- Query 1: Retrieve the names of all countries in the continent "Europe"
SELECT Name FROM Country WHERE Continent = 'Europe';

-- Query 2: Find the name and population of the city with ID 1024
SELECT Name, Population FROM City WHERE ID = 1024;

-- Query 3: List all languages spoken in countries where the CountryCode is "IND"
SELECT DISTINCT Language FROM CountryLanguage WHERE CountryCode = 'IND';

-- Query 4: Find the top 5 countries with the highest life expectancy
SELECT Name FROM Country ORDER BY LifeExpectancy DESC LIMIT 5;

-- Query 5: Retrieve all cities in the country "Australia" (CountryCode = 'AUS') with a population greater than 100,000
SELECT Name FROM City WHERE Population > 100000 AND CountryCode = 'AUS';

-- Query 6: Calculate the total population of all countries in South America
SELECT SUM(Population) AS total_population FROM Country WHERE Continent = 'South America';

-- Query 7: List the names of all cities along with the name of their country
SELECT City.Name, Country.Name 
FROM City 
LEFT JOIN Country ON City.CountryCode = Country.Code;

-- Query 8: Find the most populous city for each country (Revised to avoid ONLY_FULL_GROUP_BY error)
SELECT Country.Name AS CountryName, City.Name AS MostPopulousCity, City.Population
FROM Country
JOIN City ON Country.Code = City.CountryCode
WHERE City.Population = (
    SELECT MAX(Population)
    FROM City
    WHERE CountryCode = Country.Code
);

-- Query 9: Find countries where the official language is "Spanish" and the population is greater than 10 million
SELECT Country.Name 
FROM Country 
JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode 
WHERE Country.Population > 10000000 
AND CountryLanguage.Language = 'Spanish' 
AND CountryLanguage.IsOfficial = 'T';

-- Query 10: Example of IN - Retrieve names of countries in the continents "Asia," "Europe," or "Africa"
SELECT Name FROM Country WHERE Continent IN ('Asia', 'Europe', 'Africa');

-- Query 11: Example of BETWEEN - Find all cities with populations between 500,000 and 1,000,000
SELECT Name, Population FROM City WHERE Population BETWEEN 500000 AND 1000000;

-- Query 12: Example of LIKE - Retrieve all country names that start with the letter "A"
SELECT Name FROM Country WHERE Name LIKE 'A%';

-- Query 13: Example of EXISTS - Find all countries that have cities listed in the City table
SELECT Name FROM Country WHERE EXISTS (
    SELECT 1 FROM City WHERE City.CountryCode = Country.Code
);

-- Query 14: Example of ANY - Retrieve countries where the population is greater than the population of any city
SELECT Name FROM Country WHERE Population > ANY (
    SELECT Population FROM City
);
