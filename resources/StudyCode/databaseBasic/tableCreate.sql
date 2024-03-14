use MyStudy

/* 判断表是否存在 */
if exists (select *
           from sys.objects
           where name = 'Department'
             and type = 'U')
    drop table Department;

/* ------建表(部门，职级，员工)------ */
create table Department
(
    /* 部门编号 */
    DepartmentId     int          not null primary key identity (1,1),
    /* 部门名称 */
    DepartmentName   nvarchar(50) not null,
    /* 部门描述 */
    DepartmentRemark nvarchar(max)
)

create table Rank
(
    /* 职级编号 */
    RankId     int          not null primary key identity (1, 1),
    /* 职级名称 */
    RankName   nvarchar(50) not null,
    /* 职级描述 */
    RankRemark nvarchar(max)
)

create table People
(
    /* 员工编号 */
    PeopleId      int                                      not null primary key identity (1, 1),
    /* 部门编号 */
    DepartmentId  int                                      not null references Department (DepartmentId),
    /* 职级编号 */
    RankId        int                                      not null references Rank (RankId),
    /* 员工姓名 */
    PeopleName    nvarchar(50)                             not null,
    /* 员工性别 */
    PeopleSex     nvarchar(1)   default (N'男')
        check (PeopleSex in (N'男', N'女'))                not null,
    /* 员工生日 */
    PeopleBirth   smalldatetime                            not null,
    /* 员工工资 */
    PeopleSalary  decimal(12, 2) check (PeopleSalary >= 0) not null,
    /* 员工电话 */
    PeoplePhone   nvarchar(20)                             not null unique,
    /* 员工地址 */
    PeopleAddress nvarchar(300),
    /* 添加时间 */
    PeopleAddTime smalldatetime default (getdate())
)
