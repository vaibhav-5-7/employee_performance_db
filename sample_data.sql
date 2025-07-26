-- 1. Insert Departments
INSERT INTO departments (department_id, name, budget) VALUES
(1, 'Engineering', 1000000),
(2, 'Marketing', 750000),
(3, 'HR', 500000),
(4, 'Sales', 600000),
(5, 'Finance', 550000);

-- 2. Insert Employees
INSERT INTO employees (employee_id, first_name, last_name, email, department_id, position, salary, hire_date, is_active) VALUES
(1, 'John', 'Smith', 'john.smith@company.com', 1, 'Senior Developer', 95000, '2020-03-15', TRUE),
(2, 'Sarah', 'Johnson', 'sarah.j@company.com', 2, 'Marketing Lead', 85000, '2019-07-22', TRUE),
(3, 'Michael', 'Lee', 'michael.lee@company.com', 1, 'DevOps Engineer', 105000, '2021-01-10', TRUE),
(4, 'Emily', 'Davis', 'emily.d@company.com', 3, 'HR Manager', 75000, '2018-11-05', TRUE),
(5, 'David', 'Wilson', 'david.w@company.com', 2, 'Content Specialist', 65000, '2022-05-30', TRUE),
(6, 'Jessica', 'Brown', 'jessica.b@company.com', 1, 'Frontend Developer', 88000, '2021-09-14', TRUE),
(7, 'Robert', 'Taylor', 'robert.t@company.com', 4, 'Sales Executive', 72000, '2020-05-22', TRUE);

-- 3. Insert Performance Reviews
INSERT INTO performance_reviews (review_id, employee_id, review_date, performance_score, manager_comments, goals_completed, total_goals) VALUES
(1, 1, '2023-01-15', 4, 'Exceptional technical skills', 8, 10),
(2, 2, '2023-01-20', 5, 'Great campaign leadership', 10, 10),
(3, 3, '2023-01-18', 3, 'Needs better documentation', 6, 9),
(4, 4, '2023-01-22', 4, 'Improved onboarding process', 9, 10),
(5, 5, '2023-01-25', 2, 'Missed deadlines frequently', 3, 8),
(6, 6, '2023-02-10', 4, 'Excellent UI implementations', 7, 8),
(7, 7, '2023-02-12', 3, 'Good client relationships', 5, 7);

-- 4. Insert Projects
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status) VALUES
(101, 'Website Redesign', '2023-01-01', '2023-06-30', 50000, 'Completed'),
(102, 'Mobile App Development', '2022-11-01', '2023-03-31', 75000, 'Completed'),
(103, 'Market Research', '2023-02-01', '2023-05-15', 30000, 'Completed'),
(104, 'CRM System Upgrade', '2023-03-01', '2023-09-30', 90000, 'Active'),
(105, 'Employee Wellness App', '2023-02-01', '2023-08-31', 60000, 'Active');

-- 5. Insert Employee Project Assignments
INSERT INTO employee_projects (assignment_id, employee_id, project_id, role, hours_worked) VALUES
(1, 1, 101, 'Lead Developer', 120.5),
(2, 3, 101, 'Backend Developer', 85.0),
(3, 2, 103, 'Project Manager', 65.5),
(4, 5, 103, 'Content Writer', 42.0),
(5, 1, 102, 'Full-stack Developer', 150.0),
(6, 3, 102, 'QA Engineer', 90.5),
(7, 6, 104, 'UI Designer', 75.5),
(8, 7, 105, 'Requirement Analyst', 55.0);

-- 6. Insert Audit Log Examples
INSERT INTO employee_audit (audit_id, employee_id, changed_at, operation, old_data, new_data) VALUES
(1, 1, '2023-06-01 09:15:22', 'UPDATE', 
 '{"salary": 90000}', 
 '{"salary": 95000}'),
(2, 3, '2023-06-05 14:30:10', 'UPDATE',
 '{"position": "Junior Engineer"}',
 '{"position": "DevOps Engineer"}');