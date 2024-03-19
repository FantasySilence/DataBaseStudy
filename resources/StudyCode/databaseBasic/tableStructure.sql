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

/**
 还可以使用某些关键字，这样更新或删除时受到外键约束时会自动进行更新
 -------------------------------------------------------------------------------
 1. on delete 关键字
    cascade: 当主键表中的记录被删除时，自动删除外键表中引用该记录的所有记录。
    set null: 当主键表中的记录被删除时，将外键表中引用该记录的外键字段设置为null。
    set default: 当主键表中的记录被删除时，将外键表中引用该记录的外键字段设置为其默认值。
    no action: 如果外键表中还存在引用主键表中即将被删除记录的外键，那么删除操作会被拒绝。
    restrict: 类似于no action，禁止删除引用在外键表中的记录。
 2. on update 关键字
    cascade: 当主键表中的记录被更新时，自动更新外键表中引用该记录的外键字段。
    set null: 当主键表中的记录被更新时，将外键表中引用该记录的外键字段设置为null。
    set default: 当主键表中的记录被更新时，将外键表中引用该记录的外键字段设置为其默认值。
    no action: 如果外键表中存在引用即将被更新的主键表记录的外键，更新操作将被拒绝。
    restrict: 与no action类似，阻止对主键表中的记录进行更新，如果存在外键表中的引用。
 -------------------------------------------------------------------------------
 注意事项：
 1.使用cascade, set null, 或set default时，
  需要考虑到应用逻辑和数据一致性的需求，因为这些操作会自动修改或删除数据。
 2.set null和set default要求相应的外键字段能够接受null值或已经定义了默认值。
 */
