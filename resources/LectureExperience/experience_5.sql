use LectureExperience

/* 查询成绩等于或超过90分的学生的学号和姓名 */
select Sno, Sname
from student
where Sno in (select Sno from SC where Grade >= 90)

select Sno, Sname
from Student
where exists (select * from SC where SC.Sno = Student.Sno and Grade >= 90)

/* 找出项目J2使用的零件名称，数量 */
select pname, qty
from p
         inner join spj on p.pno = spj.pno
where jno = 'J2'

/* 找出使用上海产的零件的工程名称 */
select distinct jname
from j
where jno in (select jno
              from spj
              where sno in (select sno from s where city = N'上海'))

select distinct jname
from j
where exists(select *
             from spj
             where spj.jno = j.jno
               and sno in (select sno from s where city = N'上海'))

/* 找出没有使用天津生产的零件的工程代码 */
select distinct jno
from j
where jno not in (select jno
                  from spj
                  where sno in (select sno from s where city = N'天津'))

select distinct jno
from j
where not exists(select *
                 from spj
                 where spj.jno = j.jno
                   and sno in (select sno from s where city = N'天津'))
