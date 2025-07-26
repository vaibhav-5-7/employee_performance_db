# Employee Performance Analytics Database

![ER Diagram](database/er_diagram.png)

## 📊 Database Overview
PostgreSQL database for tracking:
- Employee records
- Performance reviews
- Project assignments
- Department budgets

## 🗃️ Sample Data Summary

### Departments
| ID | Name        | Budget    |
|----|-------------|-----------|
| 1  | Engineering | $1,000,000|
| 2  | Marketing   | $750,000  |
| 3  | HR          | $500,000  |

### Top 3 Employees
```sql
SELECT * FROM employees LIMIT 3;
```
| ID | Name          | Department | Salary  |
|----|---------------|------------|---------|
| 1  | John Smith    | Engineering| $95,000 |
| 2  | Sarah Johnson | Marketing  | $85,000 |
| 3  | Michael Lee   | Engineering| $105,000|

### Active Projects
```sql
SELECT project_name, budget FROM projects WHERE status = 'Active';
```
| Project            | Budget  |
|--------------------|---------|
| CRM System Upgrade | $90,000 |
| Employee Wellness App| $60,000|

## 🚀 Setup Instructions
1. **Restore database**:
   ```bash
   psql -U postgres -d employee_performance < database/schema.sql
   psql -U postgres -d employee_performance < database/sample_data.sql
   ```

2. **Run analysis**:
   ```sql
   -- Department performance report
   \i analysis/performance/department_metrics.sql
   ```

## 📈 Key Metrics
1. **Avg performance score**: 3.71/5
2. **Highest paid department**: Engineering ($96,667 avg)
3. **Most active project**: CRM Upgrade (75.5 hrs)

## 🔗 Resources
- [ER Diagram PDF](docs/er_diagram.pdf)
- [Data Dictionary](docs/data_dictionary.md)