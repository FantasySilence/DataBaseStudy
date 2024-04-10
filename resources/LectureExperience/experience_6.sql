use LectureExperience

/* 新创建一个表sc_cp，其存储的数据与sc相同 */
create table sc_cp
(
    Sno           char(8)  not null,
    Cno           char(5)  not null,
    Grade         smallint not null,
    Semester      char(5)  not null,
    Teachingclass char(8)  not null,
    primary key (Sno, Cno)
)

insert into sc_cp
select *
from sc

/* 对选修的数据结构课程的学生成绩增加2分 */
update sc_cp
set Grade = Grade + 2
where Cno in (select Cno from course where Cname = N'数据结构')

/* 把由S5供给J2的零件P6改为由S3供应 */
update spj
set sno = 'S3'
where jno = 'J2'
  and pno = 'P6'

/* 从供应商关系中删除S2的记录，并从供应关系情况中删除相关记录 */
delete
from spj
where sno = 'S2'
delete
from s
where sno = 'S2'

/* 将(S2, J6, P4, 200)插入供应情况关系 */
insert into s
values ('S2', N'盛锡', 10, N'北京')
insert into spj
values ('S2', 'P4', 'J6', 200)

/* 创建视图 */
create view View_sanjian as
select sno, pno, qty
from spj
where jno in (select jno from j where jname = N'三建')

select *
from View_sanjian

/* 找出三建工程使用的各种零件的代码与数量 */
select pno, SUM(qty)
from View_sanjian
group by pno

/* 找出S1供应三建工程情况 */
select View_sanjian.pno, pname, qty
from View_sanjian
         inner join p on View_sanjian.pno = p.pno
where sno = 'S1'
