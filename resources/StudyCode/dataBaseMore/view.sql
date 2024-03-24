use Banktest

/* 视图 */
-- (1).显示卡号身份证，姓名和余额
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from AccountInfo
         inner join BankCard on AccountInfo.AccountId = BankCard.AccountId;
-- 创建视图实现
create view View_Account_Card as
select CardNo 卡号, AccountCode 身份证, RealName 姓名, CardMoney 余额
from AccountInfo
         inner join BankCard on AccountInfo.AccountId = BankCard.AccountId

select * from View_Account_Card
-- 删除视图
drop view View_Account_Card

/* 视图创建了一张虚拟表，但注意，不要在这张虚拟表内修改维护数据!!! */
