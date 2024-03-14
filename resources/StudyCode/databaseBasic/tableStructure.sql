/* ------修改表的结构------ */
use MyStudy
/* 添加列 */
-- 添加员工邮箱
alter table People
    add PeopleMail varchar(200)

/* 删除列 */
-- 删除员工邮箱
alter table People
    drop column PeopleMail;

/* 修改列 */
-- 修改地址为varchar(200)
alter table People
    alter column PeopleAddress varchar(200)

/* ------维护约束------ */
/* 删除约束 */
-- 删除月薪约束
alter table People
    drop constraint CK__People__PeopleSa__4F7CD00D;

/* 添加约束(check条件) */
-- 添加月薪约束，月薪必须在1000-100000
alter table People
    add constraint CK__People__PeopleSa__4F7CD00D
        check (PeopleSalary >= 1000 and PeopleSalary <= 100000);

/* 添加约束(主键) */
-- alter table 表名 add constraint 约束名 primary key (列名)

/* 添加约束(外键) */
-- alter table 表名 add constraint 约束名 foreign key (列名) references 主表名(列名)

/* 添加约束(唯一) */
-- alter table 表名 add constraint 约束名 unique (列名)

/* 添加约束(默认值) */
-- alter table 表名 add constraint 约束名 default 默认值 for 列名
