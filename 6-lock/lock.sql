-- 获取全局锁
FLUSH TABLES WITH READ LOCK;

-- 执行需要的操作，例如备份数据库
-- 阻塞：数据更新语句（数据的增删改）、数据定义语句（包括建表、修改表结构等）和更新类事务的提交语句。
UPDATE user_wallet SET balance=1 WHERE id=1;

-- 释放全局锁
UNLOCK TABLES;