use Banktest

/* 存储过程 */
-- (1).没有输入参数,没有输出参数的存储过程
-- 定义存储过程实现查询出账户余额最低的银行卡账户信息,显示银行卡号,姓名,账户余额
create proc proc_MinMoney
as
select CardNo 卡号, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardMoney in (select min(CardMoney) from BankCard)
go

-- 使用存储过程
exec proc_MinMoney

-- (2).有输入参数,没有输出参数的存储过程
-- 模拟银行卡存钱操作,传入银行卡号,存钱金额,实现存钱操作
create proc proc_SaveMoney @CardNo varchar(20),
                           @Money money
as
update BankCard
set CardMoney = CardMoney + @Money
where CardNo = @CardNo
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values (@CardNo, @Money, 0, getdate())
go

-- 使用存储过程
exec proc_SaveMoney '6225547858741263', 1000

-- (3).有输入参数,没有输出参数,但是有返回值的存储过程(返回值必须为整数)
-- 模拟银行卡取钱操作,传入银行卡号,取钱金额,实现取钱操作
-- 取钱成功,返回1,取钱失败,返回-1
create proc proc_GetMoney @CardNo varchar(20),
                          @Money money
as
update BankCard
set CardMoney = CardMoney - @Money
where CardNo = @CardNo
    if @@ERROR <> 0
        return -1 -- 遇到return直接退出，不执行之后的代码
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values (@CardNo, 0, @Money, getdate())
    return 1
go

-- 使用存储过程
declare @returnValue int
exec @returnValue = proc_GetMoney '6225125478544587', 100
print @returnValue

-- (4).有输入参数，有输出参数的存储过程
-- 查询某时间段的银行存取款信息以及存款总金额，取款总金额
-- 传入开始时间，结束时间，显示存取款交易信息的同时，返回存款总金额，取款总金额
create proc proc_SelectExchange @start varchar(20),
                                @end varchar(20),
                                @sumIn money output,
                                @sumOut money output
as
select @sumIn = (select sum(MoneyInBank)
                 from CardExchange
                 where ExchangeTime between @start + ' 00:00:00' and @end + ' 23:59:59')
select @sumOut = (select sum(MoneyOutBank)
                  from CardExchange
                  where ExchangeTime between @start + ' 00:00:00' and @end + ' 23:59:59')
select *
from CardExchange
where ExchangeTime between @start + ' 00:00:00' and @end + ' 23:59:59'
go

-- 使用存储过程
declare @sumIn money, @sumOut money
exec proc_SelectExchange '2024-1-1', '2024-12-12',
     @sumIn output, @sumOut output
print @sumIn
print @sumOut

-- (5).有输入参数，有输出参数的存储过程
-- 密码升级，传入卡号和密码，如果卡号密码正确，并且密码长度<8，自动升级为8位密码
create proc proc_UpdatePwd @CardNo nvarchar(20),
                           @pwd nvarchar(20) output
as
if not exists(select * from BankCard where CardNo = @CardNo and CardPwd = @pwd)
    set @pwd = ''
else
begin
    if len(@pwd) < 8
    begin
        declare @len int = 8 - len(@pwd)
        declare @i int = 1
        while @i <= @len
        begin
            set @pwd = @pwd + cast(floor(rand() * 10) as varchar(1))
            set @i = @i + 1
        end
        update BankCard set CardPwd = @pwd where CardNo = @CardNo
    end
end
go

-- 使用存储过程
declare @pwd nvarchar(20) = '123456'
exec proc_UpdatePwd '6225125478544587', @pwd output
print @pwd
