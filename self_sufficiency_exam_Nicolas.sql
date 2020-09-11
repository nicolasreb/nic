--Data exploration

--Query that allows to inspect the schema of the naep table

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';

--In conclusion a number of 7 records revealed.



--Query that returns the first 50 records of the naep table.

SELECT *
FROM naep
LIMIT 50




--Query that returns summary statistics for avg_math_4_score by state. 
--Sort the results alphabetically by state name.

SELECT state, COUNT (avg_math_4_score) AS ct_avgmath4_sc, AVG (avg_math_4_score) AS avg_avgmath4_sc,
       MIN (avg_math_4_score) AS min_avgmath4_sc, MAX(avg_math_4_score) AS max_avgmath4_sc
FROM naep
GROUP BY state
ORDER BY state ASC;

--In conclusion a number of 51 states affected alphabetically from ALABAMA to WYOMING (without PortoRico and other Islands territories)




--Query that returns only the summary statistics for avg_math_4_score by state
--with differences in max and min values that are greater than 30.

SELECT state, MAX (avg_math_4_score) AS max_avgmath4_sc,
              MIN (avg_math_4_score) AS min_avgmath4_sc
FROM naep
GROUP BY state
HAVING MAX (avg_math_4_score) - MIN (avg_math_4_score) > 30;

--In conclusion: a number of 5 states affected from MISSISSIPPI to FLORIDA





--Analyzing data

--Query returns a field called bottom_10_states.
--list the states in the bottom 10 for avg_math_4_score in the year 2000.

SELECT state AS bottom_10_states, avg_math_4_score 
FROM naep
WHERE year = 2000
GROUP by state, avg_math_4_score
ORDER by avg_math_4_score
LIMIT 10;

--In concluson this abovementioned list of states show FROM DISTRICT OF COLUMBIA TO GEORGIA 




--Query that calculates the average avg_math_4_score, 
--rounded to the nearest two decimal places, 
--over all states in the year 2000.

SELECT ROUND (AVG(avg_math_4_score),2) AS avg_avgmath4_sc
FROM naep
WHERE year = 2000;

--In conclusion the result of average avg_math_4_score is 224.80




--Write a query that returns a field called below_average_states_y2000. 
--list all states with an avg_math_4_score less than the average
--over all states in the year 2000.

SELECT state AS below_average_states_y2000, avg_math_4_score 
FROM naep
WHERE year = 2000
AND avg_math_4_score < 224.80
GROUP BY state, avg_math_4_score
ORDER BY  avg_math_4_score;

--In conclusion we have 16 states affected with an average that is below the reference avg 224.80
--Starting with DISTRICT OF COLUMBIA and ENDING with RHODE ISLAND





--Write a query that returns a field called scores_missing_y2000 
--that lists any states with missing values 
--in the avg_math_4_score column of the naep table for the year 2000.

SELECT state, year, avg_math_4_score AS scores_missing_y2000
FROM naep
WHERE year = 2000
      AND avg_math_4_score is NULL
GROUP BY state, year, avg_math_4_score
ORDER BY state;

--In conclusion we have 10 records of states affected that show [null] as scores_missing_y2000




--Query that returns, for the year 2000, the state, 
--avg_math_4_score, and total_expenditure from the naep table,
--joined using the LEFT OUTER JOIN clause with the finance table. 
--Use id as the key and order the output by total_expenditure from greatest to least. 
--Make sure to round avg_math_4_score to the nearest two decimal places, 
--and then filter out NULL values in avg_math_4_scores in order to see any correlation.

SELECT f.year, ROUND(avg_math_4_score,2) , total_expenditure
FROM naep AS n
LEFT OUTER JOIN FINANCE AS f
ON n.id = f.id
WHERE f.year = 2000
     AND avg_math_4_score IS NOT NULL
GROUP BY f.year, avg_math_4_score, total_expenditure
ORDER BY total_expenditure DESC;

--In conclusion we have 41 records of such a type for the year 2000
---------------------------------------END--------------------------------------

