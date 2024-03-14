use MyStudy
/* 向部门表插入数据 */
insert into Department(DepartmentName, DepartmentRemark)
values (N'市场部', '......');
insert into Department(DepartmentName, DepartmentRemark)
values (N'软件部', '......');
insert into Department(DepartmentName, DepartmentRemark)
values (N'企划部', '......');
-- 简写方式
insert into Department
values (N'硬件部', '......');
insert into Department
values (N'总经办', '......');
-- 一次性插入多行数据
insert into Department(DepartmentName, DepartmentRemark)
values (N'测试部', '......'),
       (N'实施部', '......'),
       (N'产品部', '......');

/* 向职级表插入数据 */
insert into Rank(RankName, RankRemark)
values (N'初级', '......'),
       (N'中级', '......'),
       (N'高级', '......');

/* 向员工表中插入数据 */
insert into People (DepartmentId, RankId, PeopleName, PeopleSex,
                    PeopleBirth, PeopleSalary, PeoplePhone, PeopleAddress)
values (8, 1, N'刘备', N'男', '1988-8-8', 10000, '13888888888', N'中国');