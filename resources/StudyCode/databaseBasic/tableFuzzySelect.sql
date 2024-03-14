use MyStudy

/* 模糊查询 */

-- %可以匹配0个甚至多个字符
-- _可以匹配1个字符,有且只有1个
-- []代表匹配范围内
-- [^]代表匹配不在范围内

-- 查询出姓刘的员工信息
select *
from People
where PeopleName like N'刘%';

-- 查询名字中含有“尚”的员工信息
select *
from People
where PeopleName like N'%尚%';

-- 查询名字中含有“尚”或“操”的员工信息
select *
from People
where PeopleName like N'%尚%'
   or PeopleName like N'%操%';

-- 查询出电话号码138开头的员工信息
select *
from People
where PeoplePhone like N'138%';

-- 查询名字有两个字且姓刘的员工信息
select *
from People
where PeopleName like N'刘_';

-- 查询最后一个字为香且名字有三个字的员工信息
select *
from People
where PeopleName like N'__香';

-- 查询出电话号码138开头第四位为4或5，最后一个号码为1的员工信息
select *
from People
where PeoplePhone like N'138[4,5]%1';

-- 查询出电话号码138开头第四位为2-5之间，最后一个号码不是2和3的员工信息
select *
from People
where PeoplePhone like N'138[2,3,4,5]%[^2,3]';
select *
from People
where PeoplePhone like N'138[2-5]%[^2,3]';
