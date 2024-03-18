use LectureExperience

/* 输出学生的学号、姓名，学号只取后3位，输出标题为“截取后的学号” */
select Sname, substring(Sno, 6, 3) as 截取后的学号
from Student

/* 查询任一门课程成绩在85以上的学生的学号（在结果关系中学号没有相同的） */
select Sno
from SC
where Cno in (select Cno from SC where Grade >= 85)
group by Sno

/* 查询年龄在20~25之间（包括20，25岁）的计算机科学与技术专业学生的信息 */
select *
from Student
where Smajor = N'计算机科学与技术'
  and year(getdate()) - year(Sbirthdate) between 20 and 25

/* 用两种方法查询计算机科学与技术专业和信息安全专业学生的学号和性别 */
select Sno, Ssex
from Student
where Smajor in (N'计算机科学与技术', N'信息安全')

select Sno, Ssex
from Student
where Smajor = N'计算机科学与技术'
   or Smajor = N'信息安全'

/* 用两种方法查询既不是计算机科学与技术专业也不是信息安全专业学生的学号和性别 */
select Sno, Ssex
from Student
where Smajor not in (N'计算机科学与技术', N'信息安全')

select Sno, Ssex
from Student
where Smajor != N'计算机科学与技术'
  and Smajor != N'信息安全'

/* 查询所有2018年入学的学生，假设学号的前4位代表入学年份 */
select *
from Student
where substring(Sno, 1, 4) = 2018

/* 查询所有不姓刘的学生姓名 */
select *
from Student
where Sname not like N'刘%'

/* 查询名字中第2个字为“立”字的学生的姓名和学号 */
select *
from Student
where Sname like N'_立%'

/* 查询未分配专业的学生 */
select *
from Student
where Smajor is null

/* 查询男学生情况，查询结果按所在专业的名字升序排列，同一专业中的学生按出生日期降序排列 */
select *
from Student
where Ssex = N'男'
order by Smajor, Sbirthdate desc

/* 查询学分是3或者4的课程的先行课程的门数之和,查询现有课程门数之和 */
select count(distinct Cpno)
from Course
where Ccredit in (3, 4)

select count(distinct Cno)
from Course

/* 查询选修了3门或3门以上课程的学生学号 */
select Sno
from SC
group by Sno
having count(distinct Cno) >= 3

/* 查询选修了3门或3门以上课程的学生学号 */
select Sno
from SC
