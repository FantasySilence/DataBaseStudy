use MyStudy

select *
from People

-- 查询性别为女的员工信息
select *
from People
where PeopleSex = N'女'

-- 查询工资大于等于5000的员工信息
select *
from People
where PeopleSalary >= 5000

-- 查询月薪大于10000的员工或者月薪大于等于8000的女员工
select *
from People
where PeopleSalary > 10000
   or (PeopleSalary >= 8000 and PeopleSex = N'女')

-- 查询员工姓名中包含“张”字的员工信息
select *
from People
where PeopleName like N'%张%'

-- 查询出生年月在1980年1月1日之后且月薪大于等于8000的女员工
select *
from People
where PeopleBirth > '1980-01-01'
  and PeopleSalary >= 8000
  and PeopleSex = N'女'

-- 查询月薪在10000到20000之间的员工信息
select *
from People
where PeopleSalary >= 10000
  and PeopleSalary <= 20000
select *
from People
where PeopleSalary between 10000 and 20000

-- 查询出地址在武汉或者北京的员工信息
select *
from People
where PeopleAddress = N'武汉'
   or PeopleAddress = N'北京'
select *
from People
where PeopleAddress in (N'武汉', N'北京')

-- 查询所有员工信息，按工资降序排列
select *
from People
order by PeopleSalary desc

-- 查询所有员工信息，按名字长度排序
select *
from People
order by len(PeopleName) desc

-- 查询工资最高的五个人
select top 5 *
from People
order by PeopleSalary desc

-- 查询工资前10%的员工信息
select top 10 percent *
from People
order by PeopleSalary desc

-- 查询null/not null
select *
from People
where PeopleAddress is null
select *
from People
where PeopleAddress is not null

-- 查询80后员工的信息
select *
from People
where PeopleBirth between '1980-01-01' and '1989-12-31'
select *
from People
where PeopleBirth >= '1980-01-01'
  and PeopleBirth <= '1989-12-31'
select *
from People
where year(PeopleBirth) between 1980 and 1989

-- 查询30-40岁且工资在10000-20000之间的员工信息
select *
from People
where (year(getdate()) - year(PeopleBirth)) between 30 and 40
  and PeopleSalary between 10000 and 20000

-- 查询巨蟹座(6.22-7.22)的员工信息
select *
from People
where (month(PeopleBirth) = 6 and day(PeopleBirth) >= 22)
   or (month(PeopleBirth) = 7 and day(PeopleBirth) <= 22)

-- 查询工资比赵云高的员工信息
select *
from People
where PeopleSalary > (select PeopleSalary from People where PeopleName = N'赵云')

-- 查询所有员工信息，添加一列，显示生肖
select *,
       case
           when year(PeopleBirth) % 12 = 0 then N'猴'
           when year(PeopleBirth) % 12 = 1 then N'鸡'
           when year(PeopleBirth) % 12 = 2 then N'狗'
           when year(PeopleBirth) % 12 = 3 then N'猪'
           when year(PeopleBirth) % 12 = 4 then N'鼠'
           when year(PeopleBirth) % 12 = 5 then N'牛'
           when year(PeopleBirth) % 12 = 6 then N'虎'
           when year(PeopleBirth) % 12 = 7 then N'兔'
           when year(PeopleBirth) % 12 = 8 then N'龙'
           when year(PeopleBirth) % 12 = 9 then N'蛇'
           when year(PeopleBirth) % 12 = 10 then N'马'
           when year(PeopleBirth) % 12 = 11 then N'羊'
       end as PeopleZodiac
from People

select *,
       case year(PeopleBirth) % 12
           when 0 then N'猴'
           when 1 then N'鸡'
           when 2 then N'狗'
           when 3 then N'猪'
           when 4 then N'鼠'
           when 5 then N'牛'
           when 6 then N'虎'
           when 7 then N'兔'
           when 8 then N'龙'
           when 9 then N'蛇'
           when 10 then N'马'
           when 11 then N'羊'
       end as PeopleZodiac
from People

