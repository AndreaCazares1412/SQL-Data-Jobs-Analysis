--Question: Which skills are most optimal to learn (value = salary × demand)?

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

/*
[
  {
    "skill_id": 0,
    "skills": "sql",
    "skill_demand": "3083",
    "salary_avg": "96435",
    "score": 336459
  },
  {
    "skill_id": 1,
    "skills": "python",
    "skill_demand": "1840",
    "salary_avg": "101512",
    "score": 331418
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "skill_demand": "1659",
    "salary_avg": "97978",
    "score": 315474
  },
  {
    "skill_id": 5,
    "skills": "r",
    "skill_demand": "1073",
    "salary_avg": "98708",
    "score": 299144
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "skill_demand": "2143",
    "salary_avg": "86419",
    "score": 287864
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "skill_demand": "1044",
    "salary_avg": "92324",
    "score": 278699
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "skill_demand": "241",
    "salary_avg": "111578",
    "score": 265781
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "skill_demand": "319",
    "salary_avg": "105400",
    "score": 263900
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "skill_demand": "291",
    "salary_avg": "106440",
    "score": 262257
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "skill_demand": "187",
    "salary_avg": "113002",
    "score": 256723
  }
]

*/