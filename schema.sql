CREATE DATABASE employee_performance
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 0),
    hire_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

COMMENT ON TABLE employees IS 'Master table for all employee records';
COMMENT ON COLUMN employees.salary IS 'Annual salary in USD';

CREATE TABLE performance_reviews (
    review_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES employees(employee_id),
    review_date DATE NOT NULL,
    performance_score INT NOT NULL CHECK (performance_score BETWEEN 1 AND 5),
    manager_comments TEXT,
    goals_completed INT,
    total_goals INT,
    CONSTRAINT valid_goals CHECK (goals_completed <= total_goals)
);

CREATE INDEX idx_performance_employee ON performance_reviews(employee_id);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(12,2),
    status VARCHAR(20) CHECK (status IN ('Planning', 'Active', 'Completed', 'On Hold'))
);

CREATE TABLE employee_projects (
    assignment_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES employees(employee_id),
    project_id INT NOT NULL REFERENCES projects(project_id),
    role VARCHAR(50) NOT NULL,
    hours_worked DECIMAL(6,2) DEFAULT 0,
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE (employee_id, project_id)
);


