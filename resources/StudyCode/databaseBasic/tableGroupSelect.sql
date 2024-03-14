use MyStudy

/* 分组查询 */
-- 统计员工人数，员工工资总和，平均工资，最高和最低工资
select count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People

-- 1.根据员工所在地区分组统计员工人数，员工工资总和，平均工资，最高和最低工资
-- 方案一：基于union实现
select N'北京'           地区,
       count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
where PeopleAddress = N'北京'
union
select N'武汉'           地区,
       count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
where PeopleAddress = N'武汉'
-- 方案二：基于group by实现
select PeopleAddress     地区,
       count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
group by PeopleAddress

-- 2.根据员工所在地区分组统计员工人数，员工工资总和，平均工资，最高和最低工资
-- 1985年及以后出生的员工不参与统计
select PeopleAddress     地区,
       count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
where PeopleBirth < '1985-01-01'
group by PeopleAddress

-- 3.根据员工所在地区分组统计员工人数，员工工资总和，平均工资，最高和最低工资
-- 要求筛选出至少2人的记录，1985年及以后出生的员工不参与统计
select PeopleAddress     地区,
       count(*)          员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
where PeopleBirth < '1985-01-01'
group by PeopleAddress
having count(*) >= 2
