use MyStudy

/* 修改数据 */
-- 工资调整，每人增加1000元
update People
set PeopleSalary = PeopleSalary + 1000
-- 编号为7的员工加薪500
update People
set PeopleSalary = PeopleSalary + 500
where PeopleId = 7
-- 将软件部员工工资低于10000的调整为15000
update People
set PeopleSalary=15000
where DepartmentId = 2
  and PeopleSalary <= 10000
-- 修改刘备的工资为原来的两倍，并把刘备的地址改为北京
update People
set PeopleSalary  = PeopleSalary * 2,
    PeopleAddress = N'北京'
where PeopleName = N'刘备'

/* 删除数据 */
-- 删除市场部中工资大于10000的人
delete
from People
where DepartmentId = 3
  and PeopleSalary > 10000

-- 关于删除
/*
 * drop table People        删除整个表
 * truncate table People    清空所有数据，但表结构仍然存在
 * delete from People       清空所有数据，但表结构仍然存在
 */
-- truncate和delete的区别
/*
1.使用truncate删除数据后再添加时，自动编号仍从1开始
2.使用delete删除数据后，删除的自动编号永远不存在了，再添加时不会从1开始
*/
