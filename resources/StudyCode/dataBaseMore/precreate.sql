use Banktest

/** 示例数据库建设，便于后续操作
 * 模拟银行业务，设计测试数据库，实现以下基本需求
 * 1. 银行开户(注册个人信息)及开卡(办理银行卡)(一个人可以办理多张银行卡，但最多3张)
 * 2. 存钱
 * 3. 查询余额
 * 4. 取钱
 * 5. 转账
 * 6. 查看交易记录
 * 7. 账户挂失
 * 8. 账户注销
 */

/** 表设计
 * 1. 账户信息表
 * 2. 银行卡表
 * 3. 交易信息表(存储存钱和取钱的信息)
 * 4. 转账信息表(存储转账信息记录)
 * 5. 状态信息变化表(存储银行卡状态1:正常，2:挂失，3:冻结，4:注销)
 */

-- 表结构设计
create table AccountInfo -- 账户信息表
(
    AccountId    int primary key identity (1,1), -- 账户编号
    AccountCode  varchar(20)   not null,         -- 身份证号码
    AccountPhone varchar(20)   not null,         -- 手机号码
    RealName     varchar(20)   not null,         -- 真实姓名
    OpenTime     smalldatetime not null          -- 开户时间
)

create table BankCard -- 银行卡表
(
    CardNo    varchar(30) primary key,                                 --银行卡卡号
    AccountId int         not null references AccountInfo (AccountId), -- 账户编号
    CardPwd   varchar(30) not null,                                    -- 银行卡密码
    CardMoney money       not null,                                    -- 账户余额
    CardState int         not null,                                    -- 账户状态1:正常,2:挂失,3:冻结,4:注销
    CardTime  smalldatetime default (getdate())                        -- 开卡时间
)

create table CardExchange -- 交易信息表(存储存钱和取钱的信息)
(
    ExchangeId   int primary key identity (1, 1),                     -- 交易编号
    CardNo       varchar(30)   not null references BankCard (CardNo), -- 银行卡卡号
    MoneyInBank  money         not null,                              -- 存入金额
    MoneyOutBank money         not null,                              -- 取出金额
    ExchangeTime smalldatetime not null                               -- 交易时间
)

create table CardTransfer -- 转账信息表(存储转账信息记录)
(
    TransferId    int primary key identity (1, 1),                     -- 转账编号
    CardNoOut     varchar(30)   not null references BankCard (CardNo), -- 转出卡号
    CardNoIn      varchar(30)   not null references BankCard (CardNo), -- 转入卡号
    TransferMoney money         not null,                              -- 转账金额
    TransferTime  smalldatetime not null                               -- 转账时间
)

create table CardStateChange -- 状态信息变化表(存储银行卡状态1:正常，2:挂失，3:冻结，4:注销)
(
    StateId   int primary key identity (1, 1),                     -- 状态编号
    CardNo    varchar(30)   not null references BankCard (CardNo), -- 银行卡卡号
    OldState  int           not null,                              -- 旧状态
    NewState  int           not null,                              -- 新状态
    StateWhy  varchar(200)  not null,                              -- 状态变化原因
    StateTime smalldatetime not null                               -- 状态变化时间
)

-----------------------------------------------------------------------------------------
/* 测试 */
-- 为刘备，关羽，张飞三个人进行开户开卡操作
-- 刘备身份证：420107198905064135
-- 关羽身份证：420107199507104133
-- 张飞身份证：420107199602034138

insert into AccountInfo (AccountCode, AccountPhone, RealName, OpenTime)
values ('420107198905064135', '13554785425', N'刘备', getdate())
insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
values ('6225125478544587', 1, '123456', 0, 1)

insert into AccountInfo (AccountCode, AccountPhone, RealName, OpenTime)
values ('420107199507104133', '13454788854', N'关羽', getdate())
insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
values ('6225547858741263', 2, '123456', 0, 1)

insert into AccountInfo (AccountCode, AccountPhone, RealName, OpenTime)
values ('420107199602034138', '13456896321', N'张飞', getdate())
insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
values ('6225547854125656', 3, '123456', 0, 1)

-- 进行存钱操作，刘备存2000，关羽存8000，张飞存500000
update BankCard
set CardMoney = CardMoney + 2000
where CardNo = '6225125478544587'
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values ('6225125478544587', 2000, 0, getdate())

update BankCard
set CardMoney = CardMoney + 8000
where CardNo = '6225547858741263'
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values ('6225547858741263', 8000, 0, getdate())

update BankCard
set CardMoney = CardMoney + 500000
where CardNo = '6225547854125656'
insert into CardExchange (CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
values ('6225547854125656', 500000, 0, getdate())

-- 刘备向张飞转账1000元
update BankCard
set CardMoney = CardMoney - 1000
where CardNo = '6225125478544587'
update BankCard
set CardMoney = CardMoney + 1000
where CardNo = '6225547854125656'
insert into CardTransfer (CardNoOut, CardNoIn, TransferMoney, TransferTime)
values ('6225125478544587', '6225547854125656', 1000, getdate())
