## Create the SQL table:##
## We'll create a table in SQL based on the structure of your CSV file.##

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
  
SELECT career_aspiration, AVG(math_score) AS average_math_score
FROM students
GROUP BY career_aspiration
ORDER BY average_math_score DESC;
