use Banktest

/**
  游标：定位到结果集中某一行
  (1).静态游标：在操作游标时，数据发生变化，游标中的数据不发生变化
  (2).动态游标：在操作游标时，数据发生变化，游标中的数据改变，默认值
  (3).键基驱动游标：在操作游标时，被标识的列发生改变，游标中数据改变，其他列改变，游标中的数据不改变
 */
create table Member
(
    MemberId       int primary key identity (1,1),
    MemberAccount  nvarchar(20) unique check (len(MemberAccount) between 6 and 12),
    MemberPwd      nvarchar(20),
    MemberNickname nvarchar(20),
    MemberPhone    nvarchar(20)
)

insert into Member (MemberAccount, MemberPwd, MemberNickname, MemberPhone)
values ('liubei', '123456', N'刘备', '4659874564');
insert into Member (MemberAccount, MemberPwd, MemberNickname, MemberPhone)
values ('guanyu', '123456', N'关羽', '42354234124');
insert into Member (MemberAccount, MemberPwd, MemberNickname, MemberPhone)
values ('zhangfei', '123456', N'张飞', '41253445');
insert into Member (MemberAccount, MemberPwd, MemberNickname, MemberPhone)
values ('zhaoyun', '123456', N'赵云', '75675676547');
insert into Member (MemberAccount, MemberPwd, MemberNickname, MemberPhone)
values ('machao', '123456', N'马超', '532523523');

-- 创建游标(滚动游标，没有scroll只进)
declare myCursor cursor scroll for select MemberAccount
                                   from Member

-- 打开游标
open myCursor
-- (1).提取某行数据
fetch first from myCursor -- 第一行
fetch last from myCursor -- 最后一行
fetch absolute 2 from myCursor -- 绝对第二行
fetch relative 2 from myCursor -- 当前行下移2行
fetch next from myCursor -- 下移一行
fetch prior from myCursor
-- 上移一行
-- 举个例子,提取游标数据存入变量进行查询所有列的信息
declare @acc nvarchar(20)
fetch absolute 2 from myCursor into @acc
select *
from Member
where MemberAccount = @acc

-- 遍历游标
declare @acc nvarchar(20)
fetch absolute 1 from myCursor into @acc
while @@FETCH_STATUS = 0 -- @@FETCH_STATUS:0提取成功; -1失败; -2不存在
    begin
        print N'提取成功' + @acc
        fetch next from myCursor into @acc
    end

-- 利用游标进行数据维护
-- (1).修改
fetch absolute 2 from myCursor
update Member
set MemberPwd = '654321'
where current of myCursor
-- (2).删除
fetch absolute 2 from myCursor
delete from Member
where current of myCursor

-- 关闭游标
close myCursor

-- 删除游标
deallocate myCursor

-- 创建指向多列的游标并循环显示多列数据
declare myCursor cursor scroll for select MemberAccount, MemberPwd, MemberNickname
                                   from Member
open myCursor
declare @acc nvarchar(20)
declare @pwd nvarchar(20)
declare @nick nvarchar(20)
fetch absolute 1 from myCursor into @acc, @pwd, @nick
while @@FETCH_STATUS = 0 -- @@FETCH_STATUS:0提取成功; -1失败; -2不存在
    begin
        print N'用户名:' + @acc + N' 密码:' + @pwd + N' 昵称:' + @nick
        fetch next from myCursor into @acc, @pwd, @nick
    end

close myCursor

deallocate myCursor
