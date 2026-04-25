-- ================================================
-- HR Employee Attrition Analysis - IBM HR Dataset
-- Tool: MySQL | Author: Ashutosh Saini
-- ================================================

USE hr_analytics;

-- ================================================
-- Query 1: Overall Attrition Rate
-- Business Question: What is the overall attrition rate?
-- ================================================
SELECT 
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM employee_attrition;

-- ================================================
-- Query 2: Attrition by Department
-- Business Question: Which department has highest attrition?
-- ================================================
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM employee_attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- ================================================
-- Query 3: Salary and Attrition Connection
-- Business Question: Do low salary employees leave more?
-- ================================================
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS Avg_Monthly_Income,
    ROUND(AVG(Age), 2) AS Avg_Age,
    ROUND(AVG(TotalWorkingYears), 2) AS Avg_Experience,
    COUNT(*) AS Total_Employees
FROM employee_attrition
GROUP BY Attrition;

-- ================================================
-- Query 4: Overtime and Attrition
-- Business Question: Do overtime employees leave more?
-- ================================================
SELECT 
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM employee_attrition
GROUP BY OverTime
ORDER BY Attrition_Rate DESC;

-- ================================================
-- Query 5: Job Satisfaction and Attrition
-- Business Question: Do unhappy employees leave more?
-- ================================================
SELECT 
    JobSatisfaction,
    CASE 
        WHEN JobSatisfaction = 1 THEN 'Very Dissatisfied'
        WHEN JobSatisfaction = 2 THEN 'Dissatisfied'
        WHEN JobSatisfaction = 3 THEN 'Satisfied'
        ELSE 'Very Satisfied'
    END AS Satisfaction_Level,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM employee_attrition
GROUP BY JobSatisfaction, Satisfaction_Level
ORDER BY JobSatisfaction;

-- ================================================
-- Query 6: Age Group Attrition
-- Business Question: Which age group has highest attrition?
-- ================================================
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34 (Early Career)'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44 (Mid Career)'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54 (Senior)'
        ELSE '55+ (Near Retirement)'
    END AS Age_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM employee_attrition
GROUP BY Age_Group
ORDER BY Attrition_Rate DESC;

-- ================================================
-- Query 7: High Risk Employees
-- Business Question: Which employees are at highest risk?
-- ================================================
SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    YearsAtCompany,
    JobSatisfaction,
    OverTime,
    CASE 
        WHEN OverTime = 'Yes' 
            AND JobSatisfaction <= 2 
            AND MonthlyIncome < 5000 THEN 'Very High Risk'
        WHEN OverTime = 'Yes' 
            AND MonthlyIncome < 5000 THEN 'High Risk'
        WHEN JobSatisfaction <= 2 
            AND MonthlyIncome < 5000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category
FROM employee_attrition
WHERE Attrition = 'No'
ORDER BY MonthlyIncome ASC
LIMIT 20;

-- ================================================
-- Query 8: Final Department Summary using CTE
-- Business Question: Complete department wise attrition report
-- ================================================
WITH Department_Summary AS (
    SELECT 
        Department,
        COUNT(*) AS Total_Employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate,
        ROUND(AVG(MonthlyIncome), 2) AS Avg_Salary,
        ROUND(AVG(JobSatisfaction), 2) AS Avg_Job_Satisfaction,
        SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) AS Overtime_Employees
    FROM employee_attrition
    GROUP BY Department
)
SELECT 
    Department,
    Total_Employees,
    Employees_Left,
    Attrition_Rate,
    Avg_Salary,
    Avg_Job_Satisfaction,
    Overtime_Employees,
    CASE 
        WHEN Attrition_Rate >= 20 THEN 'Immediate Action Required'
        WHEN Attrition_Rate >= 15 THEN 'Monitor Closely'
        ELSE 'Stable'
    END AS Action_Required
FROM Department_Summary
ORDER BY Attrition_Rate DESC;