1. Performance & Productivity Analysis

--1.1Top Performers by Department
SELECT 
    e.department,
    e.first_name || ' ' || e.last_name AS employee,
    pr.performance_score,
    SUM(ep.hours_worked) AS total_hours,
    ROUND(SUM(ep.hours_worked) / NULLIF(pr.performance_score, 0), 2) AS efficiency_ratio
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.department, e.employee_id, pr.performance_score
ORDER BY e.department, pr.performance_score DESC
LIMIT 5;

--1.2Department Performance Trends
SELECT 
    department,
    ROUND(AVG(performance_score), 2) AS avg_score,
    ROUND(AVG(salary)) AS avg_salary,
    COUNT(*) AS headcount
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY department
ORDER BY avg_score DESC;

2. Financial Analysis

--2.1 Departmental Labor Cost vs. Budget

SELECT 
    e.department,
    ROUND(SUM(e.salary)/12, 2) AS monthly_salary_cost,
    COUNT(DISTINCT e.employee_id) AS headcount,
    ROUND(SUM(p.budget)/12, 2) AS monthly_budget_allocation,
    ROUND((SUM(e.salary)/SUM(p.budget))*100, 2) AS salary_to_budget_ratio
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
GROUP BY e.department
ORDER BY salary_to_budget_ratio DESC;

--2.2 Employee Cost vs. Performance ROI

WITH employee_roi AS (
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee,
        e.salary/12 AS monthly_cost,
        AVG(pr.performance_score) AS avg_score,
        SUM(ep.hours_worked) AS total_hours,
        SUM(p.budget)/NULLIF(SUM(ep.hours_worked), 0) AS revenue_per_hour
    FROM employees e
    JOIN performance_reviews pr ON e.employee_id = pr.employee_id
    JOIN employee_projects ep ON e.employee_id = ep.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    GROUP BY e.employee_id
)
SELECT 
    employee,
    monthly_cost,
    avg_score,
    ROUND((revenue_per_hour*160 - monthly_cost)/monthly_cost*100, 2) AS roi_percentage  -- 160 = avg monthly work hours
FROM employee_roi
ORDER BY roi_percentage DESC;

3. Workforce Planning

--3.1Employee Retention Risk

SELECT 
    e.first_name || ' ' || e.last_name AS employee,
    e.hire_date,
    EXTRACT(YEAR FROM AGE(NOW(), e.hire_date)) AS years_tenure,
    pr.performance_score,
    CASE
        WHEN pr.performance_score >= 4 AND EXTRACT(YEAR FROM AGE(NOW(), e.hire_date)) > 3 THEN 'High Risk (Top Performer)'
        WHEN pr.performance_score <= 2 THEN 'Performance Concern'
        ELSE 'Stable'
    END AS retention_status
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id;

--3.2 Project Resource Allocation

SELECT 
    p.project_name,
    p.status,
    COUNT(DISTINCT ep.employee_id) AS team_size,
    SUM(ep.hours_worked) AS total_hours,
    ROUND(SUM(ep.hours_worked) / COUNT(DISTINCT ep.employee_id), 2) AS avg_hours_per_employee
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id
ORDER BY total_hours DESC;

4. Advanced PostgreSQL Features

--4.1 Employee Performance Trends (Window Functions)

SELECT 
    e.first_name || ' ' || e.last_name AS employee,
    pr.review_date,
    pr.performance_score,
    ROUND(AVG(pr.performance_score) OVER (PARTITION BY e.employee_id ORDER BY pr.review_date), 2) AS rolling_avg_score,
    performance_score - LAG(performance_score, 1) OVER (PARTITION BY e.employee_id ORDER BY pr.review_date) AS score_change
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
ORDER BY e.employee_id, pr.review_date;

--4.2 Department Salary Benchmarks (Percentile Analysis)

SELECT 
    department,
    salary,
    PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) * 100 AS percentile,
    CASE 
        WHEN PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) > 0.9 THEN 'Top 10%'
        WHEN PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) < 0.1 THEN 'Bottom 10%'
        ELSE 'Middle 80%'
    END AS salary_bracket
FROM employees;


5. Data Integrity Checks

--5.1 Employees without performance reviews
SELECT e.*
FROM employees e
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id
WHERE pr.employee_id IS NULL;

--5.2 Projects missing budget data
SELECT *
FROM projects
WHERE budget IS NULL;



