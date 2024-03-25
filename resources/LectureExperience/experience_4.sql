use LectureExperience

/* 查询目前年龄大于19岁的学生信息：学号、姓名和出生年份 */
select Sno 学号, Sname 姓名, Sbirthday 出生年份
from Student
where year(getdate()) - year(Sbirthday) > 19

/* 查询学生成绩，输出姓名、课程号、成绩 */
select Sname 姓名, Cno 课程号, Grade 成绩
from SC
         inner join Student on SC.Sno = Student.Sno

/* 查询每门课程的最高分，要求得到的信息包括课程名称和分数 */
select Cname 课程名称, max(Grade) 分数
from SC
         inner join Course on SC.Cno = Course.Cno
group by Cname

/* 统计只有2名以下（含2名）学生选修的课程情况，
   统计结果包括课程号和选修人数，并按选课人数降序排列
 */
select Cno 课程号, count(*) 选修人数
from SC
group by Cno
having count(*) <= 2
order by count(*) desc

/* 查询选修了信息系统和数据库2门课程的学生的学号 */
create view CourseView as
select Sno, Cname
      from SC
               inner join Course on SC.Cno = Course.Cno
select A.Sno
from CourseView A
         join CourseView B on A.Sno = B.Sno
where A.Cname = N'数据库系统概论'
  and B.Cname = N'信息系统概论'

/* 查询每门课程的先修课程，输出课程名称和先修课程的课程名称、学分 */
select A.Cname 课程名称, B.Cname 先修课程名称, A.Ccredit 学分
from Course A
         inner join Course B on A.Cpno = B.Cno

/* 查询每门课程的先修课程，
   输出课程名称和先修课程的课程名称、学分，没有先修课程的课程也要显示
 */
select A.Cname 课程名称, B.Cname 先修课程名称, A.Ccredit 学分
from Course A
         left outer join Course B on A.Cpno = B.Cno

/* 查询年龄最大的两位学生，输出年龄和名字。提示：使用top(n)函数 */
select top 2 year(getdate()) - year(Sbirthday) 年龄, Sname 姓名
from Student
order by year(getdate()) - year(Sbirthday) desc

/* 查询成绩排名后40%的学生，输出成绩和学号。提示：使用top(n) percent */
select top 40 percent Grade, Sno 学号, Grade 成绩
from SC
order by Grade

/* 查询成绩等于或超过90分的学生的学号和姓名 */
select Student.Sno 学号, Sname 姓名
from Student
         inner join SC on Student.Sno = SC.Sno
where Grade >= 90
