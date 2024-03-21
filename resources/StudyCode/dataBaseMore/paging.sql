use MyStudy

/* 分页 */
-- 假设5条数据一页

-- 分页方式一：top分页
-- select top 每页大小 *
-- from Student
-- where StuId not in (select top 每页大小*(当前页码-1) StuId from Student)
declare @PagaSize  int = 5
declare @PageIndex int = 1
select top (@PagaSize) *
from Student
where StuId not in (select top (@PagaSize * (@PageIndex - 1)) StuId from Student)

-- 分页方案二：使用row_number分页
-- select StuId, StuName, StuSex
-- from (select row_number() over(order by StuId) RowId, * from Student) Temp
-- where RowId between (当前页码-1)*每页大小+1 and 当前页码*每页大小
declare @PagaSize  int = 5
declare @PageIndex int = 1
select StuId, StuName, StuSex
from (select row_number() over(order by StuId) RowId, * from Student) Temp
where RowId between (@PageIndex-1)*@PagaSize+1 and @PageIndex*@PagaSize
