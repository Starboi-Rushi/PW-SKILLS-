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

1)Calculate the average math_score for each career_aspiration. Order the results by the average score in descending order.
  
SELECT career_aspiration, AVG(math_score) AS average_math_score
FROM students
GROUP BY career_aspiration
ORDER BY average_math_score DESC;

2)Find the career_aspirations that have an average english_score greater than 75. Display the career aspiration and the average score.

SELECT career_aspiration, AVG(english_score) AS average_english_score
FROM students
GROUP BY career_aspiration
HAVING AVG(english_score) > 75;


3)Identify students who have a math_score higher than the school's average math score. List their first_name, last_name, and math_score.

WITH average_math AS (
    SELECT AVG(math_score) AS avg_math_score
    FROM students
)
SELECT first_name, last_name, math_score
FROM students
WHERE math_score > (SELECT avg_math_score FROM average_math);


4)Rank students within each career_aspiration category by their physics_score in descending order. Display the first_name, last_name, career_aspiration, physics_score, and the rank.

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

5) For each student, create a new column full_name by concatenating first_name and last_name with a space in between. Show the full_name and email columns where the email contains the string "academy".


SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM students
WHERE email LIKE '%academy%';



