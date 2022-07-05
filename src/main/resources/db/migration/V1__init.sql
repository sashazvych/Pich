create table catalogue
(
    id           int primary key auto_increment,
    title        varchar(60) not null,
    description  varchar(80) not null,
    type         varchar(20) not null,
    price        decimal(19,4) not null,
    ingredients  varchar(120) not null,
    allergens    varchar(120),
    imageURL     varchar(60),
    weight       int not null,
    gluten_free  boolean not null,
    lactose_free boolean not null
);

create table users
(
    id       int primary key auto_increment,
    login    varchar(40) not null,
    password varchar(40) not null,
    unique uniq_login (login)
);

create table permissions
(
    id         int primary key auto_increment,
    permission varchar(30) not null,
    unique uniq_permission (permission)
);

create table user_to_permissions
(
    user_id       int not null,
    permission_id int not null,
    constraint fk_user_to_permission_user foreign key (user_id) references users (id),
    constraint fk_user_to_permission_permission foreign key (permission_id) references permissions (id)
);

create table user_to_products
(
    user_id    int          not null,
    product_id varchar(255) not null,
    quantity   int          not null,
    constraint fk_user_to_products_user foreign key (user_id) references users (id),
    constraint fk_user_to_product_id foreign key (product_id) references catalogue (id)
);

insert into users (login, password)
values ('admin', '5F4DCC3B5AA765D61D8327DEB882CF99'),
       ('user', '5F4DCC3B5AA765D61D8327DEB882CF99');

insert into permissions (permission)
values ('ADMIN');

insert into user_to_permissions (user_id, permission_id)
values ((select id from users where login = 'admin'), (select id from permissions where permission = 'ADMIN'));