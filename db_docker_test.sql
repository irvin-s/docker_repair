/* Please, tu run this script ensure that you are using SQLite*/
create database db_docker_test
create table tb_docker_tests_results(
  id integer PRIMARY KEY AUTOINCREMENT,
  nm_image varchar(40),
  error_msg text,
  error_type varchar(40),
  possible_repair text,
  repair_source varchar(250),
  repository_maintainer_contact text
)
