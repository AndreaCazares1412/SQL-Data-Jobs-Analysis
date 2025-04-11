/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH highest_payed_skill AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_dim.skills) AS skill_demand,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM skills_job_dim
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LEFT JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE 
    job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst'
GROUP BY skills_dim.skills,  skills_dim.skill_id)


SELECT highest_payed_skill.*,
    ROUND(highest_payed_skill.salary_avg * LOG(highest_payed_skill.skill_demand)) AS score
FROM highest_payed_skill 
ORDER BY score DESC
LIMIT 10;