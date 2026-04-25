# 👥 HR Employee Attrition Analysis
### Tools: MySQL | Dataset: IBM HR Analytics

## Business Problem
A company was struggling with high employee turnover but had no 
data-driven understanding of why employees were leaving. The goal 
was to analyze 1,470 employee records to identify attrition patterns 
and provide actionable HR strategies.

## Tools Used
- MySQL — Data analysis and querying

## Key Findings
- Overall attrition rate: 16.12% (above industry benchmark of 15%)
- Sales department highest attrition: 20.63%
- Overtime employees churn 3x more: 30.53% vs 10.44%
- Under 25 age group most at risk: 39.18% attrition
- Employees who left earned $2,045 less than those who stayed
- Very dissatisfied employees churn 2x more than satisfied ones

## Analysis Performed
- Overall attrition rate calculation
- Attrition by department
- Salary and experience impact on attrition
- Overtime and work-life balance analysis
- Job satisfaction vs attrition correlation
- Age group attrition patterns
- High risk employee identification
- Department wise complete summary using CTE

## Key Insights
1. Sales department attrition 20.63% needs immediate action
2. Overtime employees leave at 30.53% vs 10.44% for non-overtime
3. Under 25 employees at 39.18% attrition — highest risk group
4. Low salary ($4,787 avg) strongly correlates with attrition
5. Very dissatisfied employees churn at 22.84% vs 11.33% for satisfied

## Business Recommendations
- Implement salary revision for Sales department employees
- Introduce overtime limits and flexible work policies
- Launch mentorship and career growth program for under 25 employees
- Conduct regular employee satisfaction surveys
- Create retention bonuses for high risk employees

## Dataset
- Source: Kaggle IBM HR Analytics Dataset
- Total Records: 1,470 employees
- Features: 35 columns including demographics, salary and satisfaction scores
