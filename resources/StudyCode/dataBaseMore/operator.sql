use Banktest

/**
  运算符
  算数运算符：加(+),减(-),乘(*),除(/),模(%)
  (注意除法是强类型除法：5/2=2，5.0/2=2.5)
  逻辑运算符：and or like in exists not all any
  赋值运算符：=
  字符串运算符：+
  比较运算符：< > = >= <= <>(不等于)
  复合运算符：+= -= /= %= *=
 */

-- (1).已知长方形的长宽，求周长和面积
declare @c int = 10, @k int = 5;
declare @zc int, @mj int;
set @zc = 2 * (@c + @k);
set @mj = @c * @k;
print N'周长:' + convert(nvarchar(10), @zc);
print N'面积:' + convert(nvarchar(10), @mj);
-- print N'周长:' + cast(@zc as nvarchar(10));
-- print N'面积:' + cast(@mj as nvarchar(10));

-- (2).关羽到银行开户，查询是否已存在账户，存在则不开户只开卡，不存在开户开卡
declare @AccountId int
if exists(select *
          from AccountInfo
          where AccountCode = '420107199507104133') -- 存在账户
    begin
        select @AccountId = (select AccountId
                             from AccountInfo
                             where AccountCode = '420107199507104133')
        insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
        values ('6225547858741264', @AccountId, '123456', 0, 1);
    end
else -- 不存在账户
    begin
        insert into AccountInfo (AccountCode, AccountPhone, RealName, OpenTime)
        values ('420107199507104133', '13656565656', N'关羽', getdate());
        set @AccountId = @@IDENTITY;
        insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
        values ('6225547858741264', @AccountId, '123456', 0, 1);
    end

-- 拓展：每人最多三张银行卡
declare @AccountId int
declare @CardCount int
if exists(select *
          from AccountInfo
          where AccountCode = '420107199507104133') -- 存在账户
    begin
        select @AccountId = (select AccountId
                             from AccountInfo
                             where AccountCode = '420107199507104133')
        select @CardCount = (select count(*)
                             from BankCard
                             where AccountId = @AccountId)
        if @CardCount <= 2
            begin
                insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
                values ('6225547858741266', @AccountId, '123456', 0, 1);
            end
        else
            begin
                print N'该账户已达上限';
            end
    end
else -- 不存在账户
    begin
        insert into AccountInfo (AccountCode, AccountPhone, RealName, OpenTime)
        values ('420107199507104133', '13656565656', N'关羽', getdate());
        set @AccountId = @@IDENTITY;
        insert into BankCard (CardNo, AccountId, CardPwd, CardMoney, CardState)
        values ('6225547858741266', @AccountId, '123456', 0, 1);
    end

-- (3).查询银行卡账户余额，是否所有的账户余额都超过了3000
if 3000 < all (select CardMoney
               from BankCard)
    begin
        print N'所有账户余额都超过了3000';
    end
else
    begin
        print N'不是所有账户余额都超过了3000';
    end

-- (4).查询银行卡账户余额，是否含有账户余额超过30000000
if 30000000 < any (select CardMoney
                   from BankCard)
    begin
        print N'含有账户余额超过30000000';
    end
else
    begin
        print N'不含有账户余额超过30000000';
    end