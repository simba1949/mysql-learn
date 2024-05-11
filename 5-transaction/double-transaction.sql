-- 创建数据库
CREATE DATABASE IF NOT EXISTS `example` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- 切换数据库
USE `example`;

-- 创建表
CREATE TABLE IF NOT EXISTS `user_wallet`
(
    `id`         BIGINT(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id`    BIGINT(20)     NOT NULL COMMENT '用户ID',
    `username`   VARCHAR(64)    NOT NULL COMMENT '用户名',
    `balance`    DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '余额',
    `gmt_modify` TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_id` (`user_id`)
) COMMENT ='用户钱包表';

-- 初始化用户钱包数据
INSERT INTO `user_wallet` (`id`, `user_id`, `username`, `balance`)
VALUES (1, 1, '李白', 1),
       (2, 2, '杜甫', 1);

-- 前置处理
-- 【会话级别】查询事务是否是自动提交，1表示是，0表示否
select @@autocommit;
-- 设置事务不自动提交
set autocommit=0;
-- 查看事务超时时间
SHOW GLOBAL VARIABLES LIKE 'innodb_lock_wait_timeout';
-- 设置 MySQL 事务超时时间
SET GLOBAL innodb_lock_wait_timeout=100;

# 查看系统级别的事务隔离级别
select @@global.transaction_isolation;
# 查看会话级别的事务隔离级别
select @@transaction_isolation;
# 查看当前正在运行的事务
SELECT * FROM information_schema.innodb_trx;

-- 恢复原值
UPDATE user_wallet SET balance = 1 WHERE user_id = 1;

-- SQL-1
SELECT balance FROM user_wallet WHERE user_id = 1;
-- SQL-2
UPDATE user_wallet SET balance = balance + 1 WHERE user_id = 1;