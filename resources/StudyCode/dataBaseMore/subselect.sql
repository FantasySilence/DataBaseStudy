use Banktest

/* 子查询 */
-- (1).关羽的银行卡号为：6225547858741263
-- 查询出余额比关羽多的银行卡信息，显示卡号，身份证，姓名，余额
-- 方案一
declare @balance money
select @balance = (select CardMoney
                   from BankCard
                   where CardNo = '6225547858741263')
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardMoney > @balance
-- 方案二:子查询
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardMoney > (select CardMoney
                   from BankCard
                   where CardNo = '6225547858741263')


-- (2).从所有账户信息中查询出余额最高的交易明细(存钱取钱记录)
-- 只能查询出一个人，有相同的话无法查询出来
select *
from CardExchange
where CardNo = (select top 1 CardNo from BankCard order by CardMoney desc)
-- 使用以下的查询解决
select *
from CardExchange
where CardNo in (select CardNo
                 from BankCard
                 where CardMoney = (select max(CardMoney) from BankCard))


-- (3).查询有取款记录的银行卡以及账户信息，显示卡号，身份证，姓名，余额
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardNo in (select CardNo from CardExchange where MoneyOutBank > 0)


-- (4).查询出没有存款记录的银行卡以及账户信息，显示卡号，身份证，姓名，余额
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardNo not in (select CardNo from CardExchange where MoneyInBank > 0)


-- (5).关羽的银行卡号为：6225547858741263,查询当天是否有受到收到转账
-- 假设张飞向关羽转账100
update BankCard
set CardMoney = CardMoney - 100
where CardNo = '6225547854125656'
update BankCard
set CardMoney = CardMoney + 100
where CardNo = '6225547858741263'
insert into CardTransfer (CardNoOut, CardNoIn, TransferMoney, TransferTime)
values ('6225547854125656', '6225547858741263', 100, getdate())

if exists(select *
          from CardTransfer
          where CardNoIn = '6225547858741263'
            and convert(varchar(22), getdate(), 23) = convert(varchar(22), TransferTime, 23))
    begin
        print N'有收到转账'
    end
else
    begin
        print N'没有收到转账'
    end


-- (6).查询出交易次数最多(存款取款操作)的银行卡账户信息
-- 显示卡号，身份证，姓名，余额，交易次数
select BankCard.CardNo 卡号,
       AccountCode     身份证,
       RealName        姓名,
       CardMoney       余额,
       myCount         交易次数
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
         inner join (select CardNo, count(*) myCount from CardExchange group by CardNo) Temp
                    on BankCard.CardNo = Temp.CardNo
where myCount in (select max(myCount)
                 from (select CardNo, count(*) myCount from CardExchange group by CardNo) Temp)


-- 查询出没有转账交易记录的银行卡账户信息，显示卡号，身份证，姓名，余额
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardNo not in (select CardNoOut from CardTransfer)
  and CardNo not in (select CardNoIn from CardTransfer)
