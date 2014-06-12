use android;
drop table apn_message;

CREATE TABLE `apn_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `srcapp` varchar(20) DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `sender_name` varchar(20) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `retry_times` int(11) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  KEY `AK_PK_APNMESSAGE` (`id`)
);






use test;

drop table if exists ssh4_task;
drop table if exists ssh4_user;
drop table if exists article;

create table ssh4_task (
	id bigint auto_increment,
	title varchar(128) not null,
	description varchar(255),
	user_id bigint not null,
    primary key (id)
) engine=InnoDB;

create table ssh4_user (
	id bigint auto_increment,
	login_name varchar(64) not null unique,
	name varchar(64) not null,
	password varchar(255) not null,
	salt varchar(64) not null,
	roles varchar(255) not null,
	register_date timestamp not null default 0,	
	icon varchar(255) ,
	primary key (id)
);


create table article
(
   id 					bigint auto_increment,
   publisher_id         int,
   content              varchar(255),
   publish_time          timestamp not null,
   img                  varchar(255),
   video                varchar(255),
   client_info          varchar(255),
   primary key (id)
);


drop table if exists friend;

drop table if exists group_info;

drop table if exists group_member;

drop table if exists group_message;

drop table if exists message;

drop table if exists user;

/*==============================================================*/
/* Table: friend                                                */
/*==============================================================*/
create table friend
(
   id                   bigint auto_increment,
   user_id              int,
   friend_id            int,
   friend_note          varchar(255),
   primary key (id)
);

/*==============================================================*/
/* Table: group                                                 */
/*==============================================================*/
create table group_info
(
   id             		bigint auto_increment,
   group_desc           varchar(255),
   group_name           varchar(255),
   create_date          datetime,
   creator_id           int,
   group_icon           varchar(255),
   primary key (id)
);

/*==============================================================*/
/* Table: group_member                                          */
/*==============================================================*/
create table group_member
(
   id                   bigint auto_increment,
   group_id             int,
   user_id              int,
   is_manager           char(1),
   recommender_id       int,
   primary key (id)
);

/*==============================================================*/
/* Table: group_message                                         */
/*==============================================================*/
create table group_message
(
   id                   int,
   group_message_id     int,
   group_id             int,
   sender_id            int,
   send_date            datetime,
   content              varchar(255),
   img                  varchar(255),
   video                varchar(255),
   primary key (id)
);

/*==============================================================*/
/* Table: message                                               */
/*==============================================================*/
create table message
(
   id 					bigint auto_increment,
   sender_id            int,
   send_date            datetime,
   content              varchar(255),
   img                  varchar(255),
   video                varchar(255),
   receiver_id          int,
   primary key (id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id 					bigint auto_increment,
   full_name            varchar(25),
   login_name           varchar(25),
   password             varchar(255),
   plain_password       char(10),
   salt                 varchar(255),
   email                varchar(25),
   register_date        datetime,
   icon                 varchar(255),
   user_desc            varchar(255),
   roles                varchar(255),
   primary key (id)
);


drop table if exists code_type;
drop table if exists code;
drop table if exists roles;
drop table if exists permissions;
drop table if exists roles_permissions;
drop table if exists user_roles;

CREATE TABLE `code_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_value` varchar(25) DEFAULT NULL,
  `type_name` varchar(25) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);


CREATE TABLE `code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_type` varchar(25) DEFAULT NULL,
  `code_value` varchar(25) DEFAULT NULL,  
  `code_name` varchar(25) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);




CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,  
  `memo` varchar(255) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);


CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,  
  `url` varchar(25) DEFAULT NULL,  
  `icon` varchar(25) DEFAULT NULL,  
  `memo` varchar(255) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);

CREATE TABLE `roles_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(25) DEFAULT NULL,
  `permission_id` varchar(25) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);

CREATE TABLE `user_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(25) DEFAULT NULL,
  `role_id` varchar(25) DEFAULT NULL,  
  PRIMARY KEY (`id`)
);


drop table if exists customer;

/*==============================================================*/
/* Table: 客户信息                                                  */
/*==============================================================*/
create table customer
(
   id                   bigint auto_increment,
   short_name           varchar(25),
   type                 varchar(2),
   full_name            varchar(255),
   url                  varchar(255),
   address              varchar(255),
   post_code            varchar(6),
   contact_person       varchar(25),
   gender               char(1),
   telephone            varchar(20),
   mobile_code          varchar(20),
   fax                  varchar(20),
   email                varchar(25),
   qq                   varchar(15),
   sales_man_id         int,
   memo                 varchar(255),
   PRIMARY KEY (id)
);

use test;

drop table if exists bill;

drop table if exists bill_detal;

drop table if exists product;

/*==============================================================*/
/* Table: bill                                                  */
/*==============================================================*/
create table bill
(
   id                   bigint auto_increment,
   bill_code            varchar(25),
   customer_id          int,
   contract_id          int,
   amount               decimal(16,2),
   sales_person_id      int,
   business_date        datetime,
   warehouse_keeper_id  int,
   warehouse_date       datetime,
   memo                 varchar(255),
   PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: bill_detail                                            */
/*==============================================================*/
create table bill_detail
(
   id                   bigint auto_increment,
   bill_id              int,
   order_number         int,
   product_id           int,
   unit_price           decimal,
   increase_quantity    int,
   decrease_quantity    int,
   memo                 varchar(255),
   PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: product                                               */
/*==============================================================*/
create table product
(
   id                   bigint auto_increment,
   name                 varchar(25),
   trade_mark           varchar(2),
   supplier_id          int,
   product_type         varchar(2),
   model                varchar(2),
   create_date          datetime,
   create_user_id       int,
   cost                 decimal,
   unit_price           decimal,
   allowance            int,
   allowance_price      decimal,
   unit                 varchar(10),
   memo                 varchar(255),
   PRIMARY KEY (id)
);



