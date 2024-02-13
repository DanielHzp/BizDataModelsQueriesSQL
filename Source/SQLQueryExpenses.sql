


--Query Expense report cases created in the last 5 years


select * from ExpenseReport 



select expensereport.Casenumber,expensereport.Stringtotalincompanycurren,expensereport.Total, * from ExpenseReport WHERE reportDate > '2018-01-01'

select * from ExpenseByCategory
select * from ExpenseList


select count(expensereport.Casenumber) as NumberofCases, YEAR(expensereport.ReportDate) as Year
from expensereport
WHERE YEAR(expensereport.ReportDate) > 2017
group by YEAR(expensereport.ReportDate)

