use LectureExperience

/**
 *定义选课数据库的表 course和sc,数据结构参照图2-1.。每个关系都需定义主码。
 *要求course表中的cpno参照 cno属性列中的数据,
 *sc表中的sno和cno参照student和course中的相关数据。
 */
create table Course
(
    Cno     char(5) primary key not null,
    Cname   nvarchar(30)        not null,
    Ccredit smallint            not null,
    Cpno    char(5) references Course (Cno)
)

create table SC
(
    Sno           char(8)  not null references Student (Sno),
    Cno           char(5)  not null references Course (Cno),
    Grade         smallint not null,
    Semester      char(5)  not null,
    Teachingclass char(8)  not null
        primary key (Sno, Cno)
)

/**
 *向表 course和sc插入数据。数据完全参照2-1
 */
insert into Course(Cno, Cname, Ccredit, Cpno)
values ('81001', N'程序设计基础与C语言', 4, null),
       ('81002', N'数据结构', 4, '81001'),
       ('81003', N'数据库系统概论', 4, '81002'),
       ('81004', N'信息系统概论', 4, '81003'),
       ('81005', N'操作系统', 4, '81001'),
       ('81006', N'Python语言', 3, '81002'),
       ('81007', N'离散数学', 4, null),
       ('81008', N'大数据技术概论', 4, '81003')

insert into SC(Sno, Cno, Grade, Semester, Teachingclass)
values ('20180001', '81001', 85, '20192', '81001-01'),
       ('20180001', '81002', 96, '20201', '81002-01'),
       ('20180001', '81003', 87, '20202', '81003-01'),
       ('20180002', '81001', 80, '20192', '81001-02'),
       ('20180002', '81002', 90, '20201', '81002-01'),
       ('20180002', '81003', 71, '20202', '81003-02'),
       ('20180003', '81001', 81, '20192', '81001-01'),
       ('20180003', '81002', 76, '20201', '81002-02'),
       ('20180004', '81001', 56, '20192', '81001-02'),
       ('20180004', '81002', 97, '20201', '81002-02'),
       ('20180005', '81003', 68, '20202', '81003-01')

select *
from Student
select *
from Course
select *
from SC

/**
 *更新李勇的学号
 */
alter table SC
    drop constraint FK__SC__Sno__534D60F1

alter table SC
    nocheck constraint FK__SC__Sno__534D60F1

update Student
set Sno = '20180008'
where Sname = N'李勇'

update SC
set Sno = '20180008'
where Sno = '20180001'

alter table SC
    check constraint FK__SC__Sno__534D60F1

alter table SC
    add constraint FK__SC__Sno__534D60F1 foreign key (Sno)
        references Student (Sno)

/**
 * 删除李勇的记录
 */
alter table SC
    drop constraint FK__SC__Sno__534D60F1

alter table SC
    nocheck constraint FK__SC__Sno__534D60F1

delete
from SC
where Sno = '20180008'

delete
from Student
where Sname = N'李勇'

alter table SC
    check constraint FK__SC__Sno__534D60F1

alter table SC
    add constraint FK__SC__Sno__534D60F1 foreign key (Sno)
        references Student (Sno)

/**
 * 删除数据库课程的记录
 */
alter table SC
    drop constraint FK__SC__Cno__5441852A
alter table Course
    drop constraint FK__Course__Cpno__49C3F6B7

alter table SC
    nocheck constraint FK__SC__Cno__5441852A
alter table Course
    nocheck constraint FK__Course__Cpno__49C3F6B7

delete
from Course
where Cno = '81003'
   or Cpno = '81003'

alter table SC
    check constraint FK__SC__Cno__5441852A
alter table Course
    check constraint FK__Course__Cpno__49C3F6B7

alter table SC
    add constraint FK__SC__Cno__5441852A foreign key (Cno)
        references Course (Cno)
alter table Course
    add constraint FK__Course__Cpno__49C foreign key (Cpno)
        references Course (Cno)

/**
 * 在SC表按学号升序和课程号降序建立索引scind, 查询显示该索引，然后删除索引
 */
create index scind on SC (Sno asc, Cno desc)

select * from sys.indexes
where object_id = object_id('SC')

drop index scind on SC
