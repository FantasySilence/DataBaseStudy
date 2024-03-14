use MyStudy

/* 多表查询 */
-- 笛卡尔乘积，将所有记录重新排列组合
select *
from People,
     Department

-- 简单多表查询
-- 查询员工信息，显示部门名称
select *
from People,
     Department
where People.DepartmentID = Department.DepartmentID

-- 查询员工信息，显示职级名称
select *
from People,
     Rank
where People.RankID = Rank.RankID

-- 查询员工信息，显示职级名称和部门名称
select *
from People,
     Department,
     Rank
where People.DepartmentID = Department.DepartmentID
  and People.RankID = Rank.RankID

-- 内连接查询
-- 查询员工信息，显示部门名称
select *
from People
         inner join Department on People.DepartmentId = Department.DepartmentId

-- 查询员工信息，显示职级名称
select *
from People
         inner join Rank on People.RankId = Rank.RankId

-- 查询员工信息，显示职级名称和部门名称
select *
from People
         inner join Department on People.DepartmentId = Department.DepartmentId
         inner join Rank on People.RankId = Rank.RankId

/* 简单多表查询和内连接的共同特点 */
-- 不符合主外键关系的数据不会被显示出来

-- 外连接查询(左外连，右外联，全外联)
-- 左外连:以左表为主表显示数据，不符合主外键关系的数据显示null
-- 查询员工信息，显示部门名称
select *
from Department
         left join People on People.DepartmentId = Department.DepartmentId

-- 查询员工信息，显示职级名称
select *
from People
         left join Rank on People.RankId = Rank.RankId

-- 查询员工信息，显示职级名称和部门名称
select *
from People
         left join Department on People.DepartmentId = Department.DepartmentId
         left join Rank on People.RankId = Rank.RankId

-- 右连接：A left join B  = B  right join A
-- 以下两个查询含义相同
-- 查询员工信息，显示职级名称
select *
from People
         left join Rank on People.RankId = Rank.RankId
select *
from Rank
         right join People on People.RankId = Rank.RankId

-- 全外联：两张表的数据无论是否符合关系都要显示
select *
from People
         full join Department on People.DepartmentId = Department.DepartmentId

/* 多表查询综合 */
-- 1.查询出武汉地区所有的员工信息，显示部门名称以及员工资料
select PeopleId       员工编号,
       DepartmentName 部门名称,
       PeopleName     员工姓名,
       PeopleSex      员工性别,
       PeopleBirth    员工生日,
       PeopleSalary   月薪,
       PeoplePhone    员工电话,
       PeopleAddress  员工地址
from People
         left join Department on People.DepartmentId = Department.DepartmentId
where PeopleAddress = N'武汉'

-- 2.查询出武汉地区所有的员工信息，显示部门名称，职级名称以及员工资料
select PeopleId       员工编号,
       DepartmentName 部门名称,
       RankName       职级名称,
       PeopleName     员工姓名,
       PeopleSex      员工性别,
       PeopleBirth    员工生日,
       PeopleSalary   月薪,
       PeoplePhone    员工电话,
       PeopleAddress  员工地址
from People
         left join Department on People.DepartmentId = Department.DepartmentId
         left join Rank on People.RankId = Rank.RankId
where PeopleAddress = N'武汉'

-- 3.根据部门分组统计员工人数，工资总和，平均工资，最高和最低工资
select DepartmentName    部门名称,
       count(PeopleId)   员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
         inner join Department on People.DepartmentId = Department.DepartmentId
group by DepartmentName, Department.DepartmentId

-- 4.根据部门分组统计员工人数，工资总和，平均工资，最高和最低工资
-- 平均工资低于10000的不参加统计，并根据平均工资降序排列
select DepartmentName    部门名称,
       count(PeopleId)   员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
         inner join Department on People.DepartmentId = Department.DepartmentId
group by DepartmentName, Department.DepartmentId
having avg(PeopleSalary) >= 10000
order by avg(PeopleSalary) desc

-- 5.根据部门名称，然后根据职位名称，
-- 分组统计员工人数，工资总和，平均工资，最高和最低工资
select DepartmentName    部门名称,
       RankName          职级名称,
       count(PeopleId)   员工人数,
       sum(PeopleSalary) 工资总和,
       avg(PeopleSalary) 平均工资,
       max(PeopleSalary) 最高工资,
       min(PeopleSalary) 最低工资
from People
         inner join Department on People.DepartmentId = Department.DepartmentId
         inner join Rank on People.RankId = Rank.RankId
group by DepartmentName, Department.DepartmentId, Rank.RankName, Rank.RankId

-- 自连接(自己连接自己)
create table Dept
(
    DeptId   int primary key, -- 部门编号
    DeptName varchar(50),     -- 部门名称
    ParentId int              -- 上级部门编号
)

-- 一级
insert into Dept(DeptId, DeptName, ParentId)
values (1, N'软件部', 0),
       (2, N'硬件部', 0)

-- 二级
insert into Dept(DeptId, DeptName, ParentId)
values (3, N'软件开发部', 1),
       (4, N'软件测试部', 1),
       (5, N'软件实施部', 1),
       (6, N'硬件开发部', 2),
       (7, N'硬件测试部', 2),
       (8, N'硬件实施部', 2)

select A.DeptId 部门编号,
       A.DeptName 部门名称,
       B.DeptName ParentDeptName
from Dept A
         inner join Dept B on A.ParentId = B.DeptId


