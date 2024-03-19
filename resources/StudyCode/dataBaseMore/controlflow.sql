use Banktest

/* 选择分支结构 */
-- (1).某用户银行卡号为：'6225547854125656'
-- 该用户进行取钱操作，取钱5000元，余额充足则进行取钱操作
-- 并提示取钱成功，否则提示余额不足
declare @balance money
select @balance = (select CardMoney
                   from BankCard
                   where CardNo = '6225547854125656')

if @balance >= 5000
    begin
        update BankCard
        set CardMoney = CardMoney - 5000
        where CardNo = '6225547854125656'
        insert into CardExchange(CardNo, MoneyInBank, MoneyOutBank, ExchangeTime)
        values ('6225547854125656', 0, 5000, getdate())
        print N'取钱成功'
    end
else
    begin
        print N'余额不足'
    end

-- (2).查询银行卡信息，将银行卡状态1，2，3，4分别转换为汉字
-- "正常", "挂失","冻结","注销"，并且根据银行卡余额显示银行卡等级
-- 30万元以下为"普通用户"，30万元以上为"VIP用户"
-- 显示列分别为卡号，身份证，姓名，余额，用户等级，银行卡状态
select CardNo                                           卡号,
       AccountCode                                      身份证,
       RealName                                         真实姓名,
       CardMoney                                        余额,
       IIF(CardMoney >= 30000, N'VIP用户', N'普通用户') 用户等级,
       case
           when CardState = 1 then N'正常'
           when CardState = 2 then N'挂失'
           when CardState = 3 then N'冻结'
           when CardState = 4 then N'注销'
           else N'异常'
           end                                          银行卡状态
from BankCard
         inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId

/* 循环结构 */
-- (1).循环打印1~10
declare @i int = 1
while @i <= 10
    begin
        print @i
        set @i = @i + 1
    end

-- (2).循环打印九九乘法表
/**
  特殊字符：char(9)——制表符, char(10)——换行符, char(13)——回车符, char(32)——空格符
 */
declare @i int = 1
while @i <= 9
    begin
        declare @str varchar(200) = ''
        declare @j int = 1
        while @j <= @i
            begin
                set @str = @str + cast(@i as varchar(1)) + '*' +
                           cast(@j as varchar(1)) + '=' +
                           cast(@i * @j as varchar(2)) + char(9)
                set @j = @j + 1
            end
        print @str
        set @i = @i + 1
    end

