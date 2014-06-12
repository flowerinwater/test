insert into ssh4_task (id, title, description, user_id) values(1, 'Study PlayFramework 2.0','http://www.playframework.org/', 2);
insert into ssh4_task (id, title, description, user_id) values(2, 'Study Grails 2.0','http://www.grails.org/', 2);
insert into ssh4_task (id, title, description, user_id) values(3, 'Try SpringFuse','http://www.springfuse.com/', 2);
insert into ssh4_task (id, title, description, user_id) values(4, 'Try Spring Roo','http://www.springsource.org/spring-roo', 2);
insert into ssh4_task (id, title, description, user_id) values(5, 'Release SpringSide 4.0','As soon as posibble.', 2);

insert into ssh4_user (id, login_name, name, password, salt, roles, register_date,icon) values(1,'admin','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into ssh4_user (id, login_name, name, password, salt, roles, register_date,icon) values(2,'user','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');

insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(15,'admin15','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(16,'user16','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(1,'admin3','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(2,'user4','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(3,'admin3','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(4,'user4','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(5,'admin5','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(6,'user6','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(7,'admin7','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(8,'user8','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(9,'admin9','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(10,'user10','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(11,'admin11','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(12,'user12','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(13,'admin13','Admin','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f','admin','2012-06-04 01:00:00','C:\headpic\smile_02.gif');
insert into user (id, login_name, full_name, password, salt, roles, register_date,icon) values(14,'user14','Calvin','2488aa0c31c624687bd9928e0a5d29e7d1ed520b','6d65d24122c30500','user','2012-06-04 02:00:00','C:\headpic\smile_04.gif');

insert into `user_roles`(`id`,`user_id`,`role_id`) values (1,'5','1');
insert into `user_roles`(`id`,`user_id`,`role_id`) values (2,'5','2');
insert into `user_roles`(`id`,`user_id`,`role_id`) values (3,'5','3');
insert into `user_roles`(`id`,`user_id`,`role_id`) values (4,'10','1');
insert into `user_roles`(`id`,`user_id`,`role_id`) values (5,'10','2');
insert into `user_roles`(`id`,`user_id`,`role_id`) values (6,'10','3');


insert into `roles`(`id`,`code`,`name`,`memo`) values (1,'1','1','1');
insert into `roles`(`id`,`code`,`name`,`memo`) values (2,'2','2','2');
insert into `roles`(`id`,`code`,`name`,`memo`) values (3,'3','3','3');





