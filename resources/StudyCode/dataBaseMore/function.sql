use Banktest

/* 函数 */
-- (1).编写一个函数,求该银行的金额总和(无参数,返回标量值)
create function GetSumMoney() returns money
as
begin
    declare @sum money
    set @sum = (select sum(CardMoney) from BankCard)
    return @sum
end

-- 函数调用
print dbo.GetSumMoney()

-- (2).传入账户编号,返回账户真实姓名
create function GetRealName(@AccId int) returns nvarchar(20)
as
begin
    declare @realName nvarchar(20)
    set @realName = (select RealName from AccountInfo where AccountId = @AccId)
    return @realName
end

-- 函数调用
print dbo.GetRealName(2)


-- (3).传递开始时间和结束时间,返回交易记录(存钱取钱),
-- 交易记录中包含真实姓名,卡号,存钱金额,取钱金额,交易时间
-- 方案一(更通用,可以处理复杂逻辑)
create function GetRecord(@start nvarchar(30), @end nvarchar(30))
    returns @result table
                    (
                        RealName     nvarchar(20),
                        CardNo       nvarchar(20),
                        MoneyInBank  money,
                        MoneyOutBank money,
                        ExchangeTime smalldatetime
                    )
as
begin
    insert into @result
    select RealName            真实姓名,
           CardExchange.CardNo 卡号,
           MoneyInBank         存钱金额,
           MoneyOutBank        取钱金额,
           ExchangeTime        交易时间
    from CardExchange
             inner join BankCard on CardExchange.CardNo = BankCard.CardNo
             inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
    where ExchangeTime between @start + ' 00:00:00' and @end + ' 23:59:59'
    return
end

-- 函数调用
select *
from dbo.GetRecord('2024-1-1', '2024-12-12')

-- 方案二(函数体内只能有return+SQL查询结果)
drop function GetRecord

create function GetRecord(@start nvarchar(30), @end nvarchar(30))
    returns table
        as
        return
        select RealName            真实姓名,
               CardExchange.CardNo 卡号,
               MoneyInBank         存钱金额,
               MoneyOutBank        取钱金额,
               ExchangeTime        交易时间
        from CardExchange
                 inner join BankCard on CardExchange.CardNo = BankCard.CardNo
                 inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
        where ExchangeTime between @start + ' 00:00:00' and @end + ' 23:59:59'
go

-- (4).查询银行卡信息,将银行卡状态1,2,3,4分别转换为汉字,"正常,挂失,冻结,注销",
-- 根据银行卡余额显示银行卡等级,30万元以下为"普通用户",30万元以上为"VIP用户",
-- 分别显示卡号,身份证,姓名,余额,用户等级,银行卡状态

-- 用户等级函数
create function GetGrade(@cardMoney money) returns nvarchar(20)
as
begin
    declare @result nvarchar(20)
    if @cardMoney >= 30000
        set @result = N'VIP用户'
    else
        set @result = N'普通用户'
    return @result
end

-- 求银行卡状态函数
create function GetCardState(@cardState int) returns nvarchar(20)
as
begin
    declare @result nvarchar(20)
    if @cardState = 1
        set @result = N'正常'
    else
        if @cardState = 2
            set @result = N'挂失'
        else
            if @cardState = 3
                set @result = N'冻结'
            else
                if @cardState = 4
                    set @result = N'注销'
                else
                    set @result = N'异常'
    return @result
end

-- 函数调用
select CardNo                      卡号,
       AccountCode                 身份证,
       RealName                    真实姓名,
       CardMoney                   余额,
       dbo.GetGrade(CardMoney)     用户等级,
       dbo.GetCardState(CardState) 银行卡状态
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId

-- (5).编写函数,根据出生日期求年龄,年龄为实岁
create function GetAge(@birth smalldatetime) returns int
as
begin
    declare @result int
    set @result = year(getdate()) - year(@birth)
    if (month(getdate()) < month(@birth))
        set @result = @result - 1
    if (month(getdate()) = month(@birth)) and (day(getdate()) < day(@birth))
        set @result = @result - 1
    return @result
end

-- 函数调用
select *, year(getdate()) - year(empBirth) 年龄 from Emp
select *, dbo.GetAge(empBirth) 年龄 from Emp
