use LectureExperience

/* 创建数据库 */
create table Student
(
    Sno        char(8) primary key,             /*学号*/
    Sname      nvarchar(8) unique not null,     /*姓名*/
    Ssex       nchar(2),                        /*性别*/
    Sbirthdate date,                            /*出生日期*/
    Smajor     varchar(30)                      /*专业*/
);

/*增加入学日期*/
alter table Student
    add S_entrance date;

/*删除入学日期*/
alter table Student
    drop column S_entrance;

/*修改数据类型*/
alter table Student
    alter column Smajor nvarchar(30);

/*插入数据*/
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180001', N'李勇', N'男', '2000-03-08', N'信息安全');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180002', N'刘晨', N'女', '1999-09-01', N'计算机科学与技术');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180003', N'王敏', N'女', '2001-08-01', N'计算机科学与技术');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180004', N'张立', N'男', '2000-01-08', N'计算机科学与技术');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180005', N'陈新奇', N'男', '2001-11-01', N'信息管理与信息系统');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180006', N'赵明', N'男', '2000-06-12', N'数据科学与大数据技术');
insert into student(Sno, Sname, Ssex, Sbirthday, Smajor)
values ('20180007', N'王佳佳', N'女', '2001-12-07', N'数据科学与大数据技术');


/*修改信息*/
update Student
set Smajor=N'计算机科学与技术'
where Sname = N'李勇';

/*创建索引*/
create index Stusmajor on Student (Smajor DESC);

/*查询*/
select *
from Student;
