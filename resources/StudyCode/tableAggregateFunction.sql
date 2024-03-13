use MyStudy

select *
from People

-- 求员工总数
select count(*) 员工总数
from People

-- 求最大值，最高的工资
select max(PeopleSalary) 最大工资
from People

-- 求最小值，最低的工资
select min(PeopleSalary) 最小工资
from People

-- 求所有员工平均工资
select avg(PeopleSalary) 平均工资
from People

-- 求所有员工工资总和
select sum(PeopleSalary) 工资总和
from People

-- 上述信息显示在一行
select count(*)          员工总数,
       max(PeopleSalary) 最大工资,
       min(PeopleSalary) 最小工资,
       avg(PeopleSalary) 平均工资,
       sum(PeopleSalary) 工资总和
from People

-- 查询武汉地区的员工人数，总工资，最高工资，最低工资，平均工资
select count(*)          员工总数,
       sum(PeopleSalary) 工资总和,
       max(PeopleSalary) 最大工资,
       min(PeopleSalary) 最小工资,
       avg(PeopleSalary) 平均工资
from People
where PeopleAddress = N'武汉'

-- 求工资高于平均工资的人员信息
select *
from People
where PeopleSalary > (select avg(PeopleSalary) from People)

-- 求数量，年龄最大值，年龄最小值，年龄总和，年龄平均值，在一行显示
select count(*)                                 数量,
       max(year(getdate()) - year(PeopleBirth)) 最大年龄,
       min(year(getdate()) - year(PeopleBirth)) 最小年龄,
       sum(year(getdate()) - year(PeopleBirth)) 年龄总和,
       avg(year(getdate()) - year(PeopleBirth)) 年龄平均值
from People
select count(*)                                    数量,
       max(datediff(year, PeopleBirth, getdate())) 最大年龄,
       min(datediff(year, PeopleBirth, getdate())) 最小年龄,
       sum(datediff(year, PeopleBirth, getdate())) 年龄总和,
       avg(datediff(year, PeopleBirth, getdate())) 年龄平均值
from People

-- 计算月薪在10000以上的男性员工的最大年龄，最小年龄，平均年龄
select max(year(getdate()) - year(PeopleBirth)) 最大年龄,
       min(year(getdate()) - year(PeopleBirth)) 最小年龄,
       avg(year(getdate()) - year(PeopleBirth)) 平均年龄
from People
where PeopleSalary > 10000
  and PeopleSex = N'男'
select max(datediff(year, PeopleBirth, getdate())) 最大年龄,
       min(datediff(year, PeopleBirth, getdate())) 最小年龄,
       avg(datediff(year, PeopleBirth, getdate())) 平均年龄
from People
where PeopleSalary > 10000
  and PeopleSex = N'男'
