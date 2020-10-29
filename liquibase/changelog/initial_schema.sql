--liquibase formatted sql
--changeset versia:initial splitStatements:true endDelimiter:;

CREATE TABLE modules (
    name varchar(50) NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT modules_pkey PRIMARY KEY(name)
);
CREATE UNIQUE INDEX modules_idx ON rbac.modules  (name);


CREATE TABLE permissions (
    name varchar(50),
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT permissions_pk PRIMARY KEY(name)
);
CREATE UNIQUE INDEX permissions_idx ON rbac.permissions (name);

CREATE TABLE roles (
    name varchar(50),
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT roles_pk PRIMARY KEY(name)
);
CREATE UNIQUE INDEX roles_idx ON rbac.roles (name);

CREATE TABLE profiles (
    name varchar(50),
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT profiles_pk PRIMARY KEY(name)
);
CREATE UNIQUE INDEX profiles_idx ON rbac.profiles  (name);


/* Table "users" */
CREATE TABLE users (
    login varchar(50) NOT NULL,
    first_name varchar(50),
    last_name varchar(50),
    activated boolean NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT users_pk PRIMARY KEY (login)
);
CREATE UNIQUE INDEX users_login_idx ON rbac.users (login,first_name,last_name);


/* Table "user_modules" */
CREATE TABLE user_profiles (

    user_login varchar(50) NOT NULL,
    profile_name varchar(50) NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT user_profiles_pk PRIMARY KEY (user_login,profile_name),
	CONSTRAINT user_profiles_fk_user FOREIGN KEY (user_login) REFERENCES rbac.users(login),
	CONSTRAINT user_profiles_fk_profile FOREIGN KEY (profile_name) REFERENCES rbac.profiles(name)
);
CREATE UNIQUE INDEX user_profiles_idx ON rbac.user_profiles (user_login,profile_name);

/* Table "user_roles" */
CREATE TABLE user_roles (
    user_login varchar(50) NOT NULL,
    role_name varchar(50) NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT user_roles_pk PRIMARY KEY (user_login,role_name),
	CONSTRAINT user_roles_fk_user FOREIGN KEY (user_login) REFERENCES rbac.users(login),
	CONSTRAINT user_roles_fk_rol FOREIGN KEY (role_name) REFERENCES rbac.roles(name)
);
CREATE UNIQUE INDEX user_roles_idx ON rbac.user_roles (user_login,role_name);


/* Table "role-permissions" */
CREATE TABLE role_permissions (
    role_name varchar(50) NOT NULL,
    permission_name varchar(50) NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT role_permissions_pk PRIMARY KEY (role_name,permission_name),
	CONSTRAINT role_permissions_fk_role FOREIGN KEY (role_name) REFERENCES rbac.roles(name),
	CONSTRAINT role_permissions_fk_permission FOREIGN KEY (permission_name) REFERENCES rbac.permissions(name)
);
CREATE UNIQUE INDEX role_permissions_idx ON rbac.role_permissions (role_name,permission_name);

CREATE TABLE profiles_modules (
    profile_name varchar(50) NOT NULL,
    module_name varchar(50) NOT NULL,
    created_date timestamp DEFAULT now(),
    updated_date timestamp NULL,
    CONSTRAINT profiles_modules_pk PRIMARY KEY (profile_name,module_name),
	CONSTRAINT profiles_modules_fk_profile FOREIGN KEY (profile_name) REFERENCES rbac.profiles(name),
	CONSTRAINT profiles_modules_fk_module FOREIGN KEY (module_name) REFERENCES rbac.modules(name)
);
CREATE UNIQUE INDEX profiles_modules_namex ON rbac.profiles_modules (profile_name,module_name);


