use Banktest

/* 事务 */
-- (1).假设刘备取款6000，添加约束，设置账户余额必须大于等于0，
-- 使用事务实现修改余额和添加取款记录
alter table BankCard
    add constraint ck_money check (CardMoney >= 0)

begin transaction
declare @myError int = 0
update BankCard
set CardMoney = CardMoney - 1
where CardNo = '6225125478544587'
set @myError = @myError + @@ERROR
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values ('6225125478544587', 0, 1, getdate())
set @myError = @myError + @@ERROR
if @myError = 0
    begin
        print N'取款成功'
        commit transaction
    end
else
    begin
        print N'取款失败'
        rollback transaction
    end

-- (2).刘备向张飞转账1000元，张飞添加1000块，刘备扣除1000块，生成转账记录
begin transaction
declare @myError int = 0
update BankCard
set CardMoney = CardMoney - 1
where CardNo = '6225125478544587'
set @myError = @myError + @@ERROR
update BankCard
set CardMoney = CardMoney + 1
where CardNo = '6225547854125656'
set @myError = @myError + @@ERROR
insert into CardTransfer(CardNoOut, CardNoIn, TransferMoney, TransferTime)
values ('6225125478544587', '6225547854125656', 1, getdate())
set @myError = @myError + @@ERROR
if @myError = 0
    begin
        print N'转账成功'
        commit transaction
    end
else
    begin
        print N'转账失败'
        rollback transaction
    end
