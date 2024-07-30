SELECT career_aspiration, AVG(math_score) AS average_math_score
FROM students
GROUP BY career_aspiration
ORDER BY average_math_score DESC;
