# 请在以下适当的空白处填写SQL语句，完成任务书的要求。空白行可通过回车换行添加。 
create database if not exists TestDb;
use TestDb;
drop table if exists t_emp;
create table t_emp(
    id int primary key,
    name varchar(32),
    deptId int,
    salary float
);




/* *********** 结束 ************* */