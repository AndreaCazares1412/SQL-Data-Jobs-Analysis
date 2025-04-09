/*
1. What are the top-paying jobs for my role? (Data Analyst)
2. What are the skills required for these top-paying roles?
3. What are the most in-demand sjills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
  a. Optimal: High Demand AND High Paying
*/

/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT 
  job_id, 
  job_title,
  job_location, 
  job_schedule_type, 
  salary_year_avg, 
  job_posted_date::DATE,
  c.name AS company
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS c ON  jpf.company_id = c.company_id
WHERE 
  job_work_from_home = True AND
  job_location = 'Anywhere' AND 
  salary_year_avg IS NOT NULL AND 
  job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 10;