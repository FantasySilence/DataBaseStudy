use Banktest

/**
  触发器
  (1).instead of 触发器:在执行操作之前被执行
  (2).after 触发器:在执行操作之后被执行
  与级联更新相同,慎用!!!
 */

select *
from People
select *
from Dep

-- (1).假设有部门表和员工表,添加员工时,该员工的部门编号找不到
-- 则自动添加部门信息,部门名称为新部门
create trigger tri_InsertPeople
    on People
    after insert
    as
    if not exists(select *
                  from Dep
                  where DepartmentId = (select DepartmentId from inserted))
        begin
            insert into Dep(DepartmentId, DepartmentName)
            values ((select DepartmentId from inserted), N'新部门')
        end
go

-- 测试触发器
insert into People(DepartmentId, PeopleName, PeopleSex, PeoplePhone)
values ('003', N'赵云', N'男', '13698547125')
insert into People(DepartmentId, PeopleName, PeopleSex, PeoplePhone)
values ('006', N'马超', N'男', '13698547125')

-- (2).触发器实现,删除一个部门时将部门下所有员工删除
create trigger tri_DeleteDep
    on Dep
    after delete
    as
    delete
    from People
    where DepartmentId = (select DepartmentId from deleted)
go

-- 测试触发器
delete
from Dep
where DepartmentId = '006'

-- (3).创建一个触发器,删除一个部门是判断该部门是否有员工,有则不删除,没有则删除
drop trigger tri_DeleteDep
create trigger tri_DeleteDep
    on Dep
    instead of delete
    as
    if not exists(select *
                  from People
                  where DepartmentId = (select DepartmentId from deleted))
        begin
            delete from Dep where DepartmentId = (select DepartmentId from deleted)
        end
go

-- 测试触发器
delete
from Dep
where DepartmentId = '001'

-- (4).修改一个部门编号后,该部门下所有员工的部门编号同步更改
create trigger tri_UpdateDept
    on Dep
    after update
    as
    update People
    set DepartmentId = (select DepartmentId from inserted)
    where DepartmentId = (select DepartmentId from deleted)
go

-- 测试触发器
update Dep
set DepartmentId = '005'
where DepartmentId = '001'
