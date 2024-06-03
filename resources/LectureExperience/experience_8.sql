use LectureExperience

/* 采用系统管理员账户创建登录名及数据库用户u2 */
create login u2 with password = '123456',
    default_database = LectureExperience
create user u2 for login u2

/* 系统管理员账户创建course */
create table courses
(
    id     int primary key identity (1,1),
    name   varchar(50),
    credit int
)
insert into courses(name, credit)
values (N'数据库', 3)
insert into courses(name, credit)
values (N'编译原理', 3)
insert into courses(name, credit)
values (N'计算机组成原理', 3)

/* 把读course的权限授予给u2 */
grant select on courses to u2
/* 测试读取course */
select *
from courses

/* 授予U2更新course的credit权限 */
grant update on courses.credit to u2
/* 测试更新credit */
update courses
set credit = 4
where id = 1

/* 回收u2的更新credit权限 */
revoke update on courses.credit from u2
/* 测试更新credit */
update courses
set credit = 4
where id = 1

/* 授予u2创建表权限，以及为它创建可访问的架构并编写命令测试u2是否能创建一个表 */
grant create table to u2
create table u2_test
(
    id   int primary key identity (1, 1),
    name varchar(50)
)
