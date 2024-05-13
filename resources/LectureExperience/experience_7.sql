use LectureExperience

/* 1.统计任意课程的成绩分布，即按照各分数段统计人数 */
create proc proc_cal_distribution @Course nvarchar(20)
as
begin
    select case
               when Grade between 0 and 59 then '0-59'
               when Grade between 60 and 69 then '60-69'
               when Grade between 70 and 79 then '70-79'
               when Grade between 80 and 89 then '80-89'
               when Grade between 90 and 100 then '90-100'
               end
                        as '分数段',
           count(Grade) as '人数'
    from SC
             inner join Course on SC.Cno = Course.Cno
    where Cname = @Course
    group by case
                 when Grade between 0 and 59 then '0-59'
                 when Grade between 60 and 69 then '60-69'
                 when Grade between 70 and 79 then '70-79'
                 when Grade between 80 and 89 then '80-89'
                 when Grade between 90 and 100 then '90-100'
                 end
end
go

exec proc_cal_distribution N'数据结构'


/* 2.统计任意一门课程的平均成绩 */
create proc proc_cal_average @Course nvarchar(20), @score smallint output
as
select @score = avg(Grade)
from SC
where Cno = (select Cno from Course where Cname = @Course)
go

declare @average       smallint
declare @target_course nvarchar(20) = N'程序设计基础与C语言'
exec proc_cal_average @target_course,
     @average output
print @target_course + N'的平均分为：' + cast(@average as nvarchar(5))


/* 3.百分制转换为等级制 */
create proc proc_score_to_level
as
select student.Sno,
       Sname,
       Cname,
       Grade,
       case
           when Grade >= 90 then 'A'
           when Grade >= 80 then 'B'
           when Grade >= 70 then 'C'
           when Grade >= 60 then 'D'
           else 'E'
           end
from SC
         inner join student on SC.Sno = student.Sno
         inner join Course on SC.Cno = Course.Cno
go

exec proc_score_to_level
