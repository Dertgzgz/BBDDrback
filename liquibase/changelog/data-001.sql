--liquibase formatted sql
--changeset versia:update splitStatements:true endDelimiter:;

INSERT INTO modules ("name") VALUES('m1'),('m2'),('m3'),('m4');

INSERT INTO users ("login","activated") VALUES('u1',true),('u2',true),('u3',true),('u4',true);

INSERT INTO roles ("name") VALUES('r1'),('r2'),('r3');

INSERT INTO profiles ("name") VALUES('p1'),('p2'),('p3');

INSERT INTO permissions ("name") VALUES('read'),('write'),('delete');

INSERT INTO role_permissions (role_name,permission_name) VALUES('r1','read'),('r2','read'),('r2','write'),('r3','read'),('r3','delete');

INSERT INTO user_roles (user_login,role_name) VALUES('u1','r1'),('u2','r1'),('u2','r2'),('u3','r3'),('u4','r2'),('u4','r3');

INSERT INTO user_profiles (user_login,profile_name) VALUES('u1','p1'),('u2','p1'),('u2','p2'),('u3','p3'),('u4','p2'),('u4','p3');

INSERT INTO profiles_modules (profile_name,module_name) VALUES('p1','m1'),('p2','m1'),('p2','m2'),('p3','m3'),('p3','m1'),('p3','m2');


