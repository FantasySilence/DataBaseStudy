use MyStudy
-- 查询所有行
select *
from Department
select *
from Rank
select *
from People
-- 查询指定列(姓名，生日，月薪，电话)
select PeopleName, PeopleBirth, PeopleSalary, PeoplePhone
from People
-- 查询指定列(姓名，生日，月薪，电话)显示中文列名
select PeopleName 姓名, PeopleSex 性别, PeopleBirth 生日,
       PeopleSalary 月薪, PeoplePhone 电话
from People
-- 查询出员工所在城市
select PeopleName, PeopleAddress
from People
-- 查询出员工所在城市(不需要重复数据)
select distinct PeopleAddress
from People
-- 假设准备涨薪20%，查询出涨薪前后的月薪
select PeopleName, PeopleSex, PeopleSalary, PeopleSalary * 1.2 加薪后的工资
from People
