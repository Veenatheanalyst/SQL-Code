
--1) What is the lowest salary per JobTitle?
select JobTitle, Min(Salary) as LowestSalary from EmployeeSalary
group by JobTitle
order by JobTitle


--2) What are the unique JobTitles in the Table 'EmployeeSalary'?
select Distinct (JobTitle) from EmployeeSalary


--3)What are the unique JobTitles along with the Length of the JobTitles in the Table 'EmployeeSalary'?
select Distinct (JobTitle), Len (JobTitle) as LenValue from EmployeeSalary


--4) How to find Difference in dates?
Select datediff(YEAR,'1988-12-12',getdate()) as OldMe


--5) Name the JobTitles that appear more than once?
select JobTitle, count(JobTitle) Jobnum from EmployeeSalary
group by JobTitle
having count(JobTitle)>2


--6) Provide all the details from the table EmployeeSalary where JobTitle is not 'Salesman'?
select * from EmployeeSalary
where JobTitle <>'Salesman'


--7) Show the detail of the properties where the SaleDateConverted date is between '2015-01-01' AND '2017-01-01'
select * from NashvilleHousing
where SaleDateConverted between '2015-01-01' AND '2017-01-01'

select * from NashvilleHousing
where SaleDateConverted > '2015-01-01' AND SaleDateConverted <'2017-01-01'

--8) Select the Third highest salary?
Select Top 1 * from
(select Top 3 * from EmployeeSalary
order by salary desc) as Emp
order by salary

--9) Print Alternate columns from the table?
with RN_CTE 
as
(select *, ROW_NUMBER() over(order by salary) as RN from EmployeeSalary)
select* from RN_CTE
where (RN % 2)= 1


--10) How to insert values in a Table?

Insert into EmployeeSalary
Values ('1011','Salesman','43000'),
		('1012', 'HR', '50000')


select * from EmployeeSalary

--11) How to delete Duplicate rows of Data?

with RowNumCTE
as(select EmployeeID,jobTitle, salary, ROW_NUMBER() over(Partition by EmployeeID,jobTitle,salary order by salary) as RN from EmployeeSalary)
Delete from RowNumCTE
where RN>1 

--11) How to print Duplicate rows of data?

--Without CTE

select *, Count (*) from EmployeeSalary
group by EmployeeID, JobTitle, salary
having count(EmployeeID) >1 and count(JobTitle) >1 and count(salary) >1
order by EmployeeID


--With CTE 

With DupCTE as
(select EmployeeID, JobTitle, salary, count(*) as Dup from EmployeeSalary
group by EmployeeID, JobTitle, salary
Having count(EmployeeID)>1 and count(JobTitle) >1 and count(salary)>1
) 

delete from DupCTE
--12) Creating Table and Inserting Values in it...


create Table EmpManager
(Emp_id int,
Emp_name varchar(50),
salary int,
Manager_id int)


Insert into EmpManager
Values (1,'Garry',11000,3),
		(2,'Gibbs', 10000,1),
		(3, 'Smith', 19000,4),
		(4, 'Latham', 25000,0),
		(5,'Jimmy', 12000,3)

select * from EmpManager

--13a) Selecting JobTitles that have exactly 2 a's?

select * from EmployeeSalary
where (Len(JobTitle)-len(replace(UPPER(JobTitle),'A',''))) = 2


--13b)
--Etract 4 characters starting from the second position

select JobTitle, SUBSTRING(JobTitle,2,4) from EmployeeSalary

select Substring ('VeenaKumar',2, 4) 
--14) Self join, select the JobTitles within the Table that have same salary?

select Distinct(e.EmployeeID), e.JobTitle, e.salary 
from EmployeeSalary as e, EmployeeSalary as f
where  e.salary = f.salary and e.EmployeeID <> f.EmployeeID
order by EmployeeID

--Another way 
select Distinct(e.EmployeeID), e.JobTitle, e.salary 
from EmployeeSalary as e 
join EmployeeSalary as f
on e.salary = f.salary
where
e.EmployeeID <> f.EmployeeID
order by EmployeeID


select * from EmployeeSalary

--15) How to Update Table with new data?
Update EmployeeSalary
set EmployeeID = 1013
where EmployeeID IS NULL

--16) Create CTE?
with RowNumCTE
as(select EmployeeID,jobTitle, salary, ROW_NUMBER() over(Partition by salary order by salary) as RN from EmployeeSalary)
select Distinct(EmployeeID),jobTitle, salary from RowNumCTE
where RN>1 


--17) How to print one row twice?
Select * from EmployeeSalary
where JobTitle = 'HR'
Union All
Select * from EmployeeSalary
where JobTitle = 'HR'
Order by EmployeeID

--18) Create Case Statements?
Select * from EmployeeSalary

Select salary,
case when salary =50000 then salary+ 10000
else salary
end
from EmployeeSalary

--19)Creating Table Num1 and inserting values?
create Table NUM1
(num1 int)

select * from NUM1

Insert Into NUM1
Values (-3),
		(9),
		(-2),
		(1),
		(0),
		(-5),
		(8),
		(-4),
		(1)
--20)Case Statements
		select num1, 
      (case when num1 = 0 then num1+ 10
	   when num1 = 1 then num1+ 20
	   else num1 
	   end ) as NumCase
from NUM1

--21) How to Add all the _ve and +ve Values separately.
Select sum(case when num1> 0 then num1 else 0 end) as Sum_Pos,
sum(case when num1 < 0 then num1 else 0 end) as Sum_Neg
from NUM1

--22)Everything in EmployeeDemographics which is not present in EmployeeSalary

select * from EmployeeSalary s
right join EmployeeDemographics e
on e.EmployeeID =s.EmployeeID
where s.EmployeeID IS  NULL

--
select * from EmployeeDemographics

select EmployeeID from EmployeeSalary
where EmployeeID not in (select EmployeeID from EmployeeDemographics)

--23)Find the NashvilleHousing data for SaleDateConverted,the last day of the month.
select * from NashvilleHousing
where SaleDateConverted =EOMONTH(SaleDateConverted)
order by [UniqueID]

--24)Top 5 Houses with the highest TotalValue sold in the year 2015.
select Top 5 * from NashvilleHousing
where year(SaleDateConverted) = '2015'
order by TotalValue desc


















