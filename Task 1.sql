## Create the SQL table:
## We'll create a table in SQL based on the structure of your CSV file.
    
CREATE TABLE students (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    gender VARCHAR(10),
    part_time_job BOOLEAN,
    absence_days INT,
    extracurricular_activities BOOLEAN,
    weekly_self_study_hours INT,
    career_aspiration VARCHAR(100),
    math_score INT,
    history_score INT,
    physics_score INT,
    chemistry_score INT,
    biology_score INT,
    english_score INT,
    geography_score INT
);

## Import the CSV data into the SQL table:
## Load the data from the CSV file into the newly created SQL table.

## 1)Calculate the average math_score for each career_aspiration. Order the results by the average score in descending order.
  
SELECT career_aspiration, AVG(math_score) AS average_math_score
FROM students
GROUP BY career_aspiration
ORDER BY average_math_score DESC;

## 2)Find the career_aspirations that have an average english_score greater than 75. Display the career aspiration and the average score.

SELECT career_aspiration, AVG(english_score) AS average_english_score
FROM students
GROUP BY career_aspiration
HAVING AVG(english_score) > 75;


## 3)Identify students who have a math_score higher than the school's average math score. List their first_name, last_name, and math_score.

WITH average_math AS (
    SELECT AVG(math_score) AS avg_math_score
    FROM students
)
SELECT first_name, last_name, math_score
FROM students
WHERE math_score > (SELECT avg_math_score FROM average_math);


## 4)Rank students within each career_aspiration category by their physics_score in descending order. Display the first_name, last_name, career_aspiration, physics_score, and the rank.

WITH RankedStudents AS (
    SELECT
        first_name,
        last_name,
        career_aspiration,
        physics_score,
        ROW_NUMBER() OVER (PARTITION BY career_aspiration ORDER BY physics_score DESC) AS rank
    FROM students
)
SELECT
    first_name,
    last_name,
    career_aspiration,
    physics_score,
    rank
FROM RankedStudents
ORDER BY career_aspiration, rank;

## 5) For each student, create a new column full_name by concatenating first_name and last_name with a space in between. Show the full_name and email columns where the email contains the string "academy".


SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM students
WHERE email LIKE '%academy%';

## 6)Calculate the lowest (FLOOR), highest (CEIL), and average (ROUND to two decimal places) chemistry_score for each career aspirant. Display the career aspirants, lowest score, highest score, and average score.

SELECT
    career_aspiration,
    MIN(chemistry_score) AS lowest_score,
    MAX(chemistry_score) AS highest_score,
    ROUND(AVG(chemistry_score), 2) AS average_score
FROM students
GROUP BY career_aspiration;


## 7)Find career aspirations where the average history_score is above 85 and at least 5 students aspire to that career. List the career_aspiration and the average score.

SELECT
    career_aspiration,
    ROUND(AVG(history_score), 2) AS average_history_score
FROM students
GROUP BY career_aspiration
HAVING AVG(history_score) > 85 AND COUNT(*) >= 5;


## 8)Identify students who score above average in both biology and chemistry, compared to the school's average for those subjects. Display their id, first_name, last_name, biology_score, and chemistry_score.

WITH Averages AS (
    SELECT
        AVG(biology_score) AS avg_biology,
        AVG(chemistry_score) AS avg_chemistry
    FROM students
),
AboveAverageStudents AS (
    SELECT
        id,
        first_name,
        last_name,
        biology_score,
        chemistry_score
    FROM students, Averages
    WHERE biology_score > Averages.avg_biology
      AND chemistry_score > Averages.avg_chemistry
)
SELECT
    id,
    first_name,
    last_name,
    biology_score,
    chemistry_score
FROM AboveAverageStudents;


## 9)Calculate the percentage of absence days for each student relative to the total absence days recorded for all students. Display the id, first_name, last_name, and the calculated percentage, rounded to two decimal places. Order the results by the percentage in descending order.


WITH TotalAbsences AS (
    SELECT SUM(absence_days) AS total_absence_days
    FROM students
),
StudentAbsencePercentage AS (
    SELECT
        id,
        first_name,
        last_name,
        absence_days,
        ROUND((absence_days * 100.0 / TotalAbsences.total_absence_days), 2) AS percentage_absence
    FROM students, TotalAbsences
)
SELECT
    id,
    first_name,
    last_name,
    percentage_absence
FROM StudentAbsencePercentage
ORDER BY percentage_absence DESC;


## 10)Identify students who have scores above 80 in at least three out of the six subjects: math, history, physics, chemistry, biology, and English. Display their id, first_name, last_name, and the count of subjects where they scored above 80.

SELECT
    id,
    first_name,
    last_name,
    subjects_above_80
FROM (
    SELECT
        id,
        first_name,
        last_name,
        (CASE WHEN math_score > 80 THEN 1 ELSE 0 END +
         CASE WHEN history_score > 80 THEN 1 ELSE 0 END +
         CASE WHEN physics_score > 80 THEN 1 ELSE 0 END +
         CASE WHEN chemistry_score > 80 THEN 1 ELSE 0 END +
         CASE WHEN biology_score > 80 THEN 1 ELSE 0 END +
         CASE WHEN english_score > 80 THEN 1 ELSE 0 END) AS subjects_above_80
    FROM students
) AS subquery
WHERE subjects_above_80 >= 3;



                                 ## Thank You ##
    ## Rushikesh Bhamare_CuvetteDS ##


