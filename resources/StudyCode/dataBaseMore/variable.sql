use Banktest

/* 变量：局部变量与全局变量 */
-- (1).局部变量，以@开头，先声明，后赋值
declare @str varchar(20) = 'hello'
print @str
-- 或者
declare @str varchar(20)
set @str = 'hello'
select @str = 'hello'
print @str

/**
  使用set和select赋值的区别
  1.set: 给变量赋予指定的值
  2.select：一般用于表中查询出的数据赋值给变量，如果有多条，则取最后一条
  例如：select @str = 字段名 from 表名
*/

-- (2).全局变量，以@@开头，由系统进行维护和定义
/**
  常用的全局变量
  1.@@ERROR：返回上一条语句执行时的错误代码
  2.@@IDENTITY：返回最后插入的标识值
  3.@@ROWCOUNT：返回上一条语句执行后，影响的行数
  4.@@TRANCOUNT：返回当前连接的活动事务数
  5.@@MAX_CONNECTIONS：返回当前数据库的最大连接数
  6.@@SERVERNAME：返回运行SQL Server的本地服务器的名称
  7.@@SERVICENAME：返回SQL Server正在其下运行的注册表项的名称
  8.@@LOCK_TIMEOUT：返回当前数据库的锁超时时间(毫秒)
 */
-- 示例
-- (1).为赵云进行开卡开户操作，赵云身份证：420107199904054233
insert into AccountInfo(AccountCode, AccountPhone, RealName, OpenTime)
values ('420107199904054233', '13554785965', N'赵云', getdate());

declare @accountId int = @@IDENTITY
insert into BankCard(CardNo, AccountId, CardPwd, CardMoney, CardState)
values ('6225125478544588', @accountId, '123456', 0, 1);

-- (2).需要求出张飞的银行卡号和余额
declare @accountId int = (select AccountId
                          from AccountInfo
                          where RealName = N'张飞')
select CardNo 卡号, CardMoney 余额
from BankCard
where AccountId = @accountId

/**
  go语句
  1.等待go语句之前的代码执行完后才能执行后面的代码
  -以创建数据库为例：
  create database test
  go
  use test
  create table testTable
  (
    id int identity primary key,
    name varchar(20)
  )
  insert into testTable(name) values('张三');

  2.批处理结束的标值
 */
declare @num int    -- @num作用范围全局
set @num = 1
set @num = 2

go
declare @num int    -- @num作用域在最近的两个go之间
set @num = 1
go
-- set @num = 2