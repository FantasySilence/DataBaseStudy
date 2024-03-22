use Banktest

/* 索引 */
select *
from AccountInfo
where AccountCode = '420107199507104133'

-- 给AccountInfo中的AccountCode添加索引
create unique nonclustered index IX_AccountCode
    on AccountInfo (AccountCode)
-- with
-- (
--     pad_index = on,
--     ignore_dup_key = off,
--     allow_row_locks = on,
--     allow_page_locks = on,
--     data_compression = none
-- )

-- 查看索引
select *
from sys.indexes
where name = 'IX_AccountCode'

-- 删除索引
drop index IX_AccountCode on AccountInfo

-- 查询
select *
from AccountInfo with (index = IX_AccountCode)
where AccountCode = '420107199507104133'
