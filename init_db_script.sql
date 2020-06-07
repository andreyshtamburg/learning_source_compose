create table users (
    "id"            serial,
    "admin"         boolean not null default false,
    "email"         varchar(64) not null unique,
    "password_hash" varchar(128),
    "first_name"    varchar(64) not null,
    "last_name"     varchar(64) not null,
    "uuid"          varchar(128) not null,
    "created_at"    timestamp not null default current_timestamp,
    "last_updated"  timestamp not null default current_timestamp,
    constraint user_id_pkey primary key (id)
);

create table sources (
    "id"           serial,
    "name"         varchar(128) not null,
    "description"  varchar(1024),
    "link"         varchar(256),
    "created_at"   timestamp   not null default current_timestamp,
    "last_updated" timestamp   not null default current_timestamp,
    "user_id"      integer,
    constraint source_id_pkey primary key (id),
    constraint sources_user foreign key (user_id) references users (id) on delete cascade
);

create table tags (
    "id"           serial,
    "name"         varchar(16) not null,
    constraint tag_id_pkey primary key (id)
);

create table source_tag (
    "source_id"    integer,
    "tag_id"       integer,
    constraint source_tag_id primary key (source_id, tag_id),
    constraint source_tag_sources foreign key (source_id) references sources (id) on delete cascade,
    constraint source_tag_tags foreign key (tag_id) references tags (id) on delete cascade
);

create table blacklist_tokens (
    "id"            serial,
    "token"         varchar(500) not null unique,
    "blacklisted_on" timestamp  not null,
    constraint blacklist_id_pkey primary key (id)
);

insert into users (admin, email, first_name, last_name, uuid, password_hash)
values
(true, 
'andrewshtamburg@gmail.com', 
'Andrei', 
'Shtamburg', 
'6295de0e-0584-404c-a165-5bd642a3188f',
'5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');

insert into tags (name) 
values 
('python'),
('java'),
('js'),
('docker'),
('flask'),
('mongodb'),
('pymongo'),
('react'),
('full stack');

insert into sources (name, description, link, created_at, last_updated, user_id)
values ('CRUD app with mongo and flask', 'Okta developer explains how to create a simple CRUD app using flask, mongodb, docker-compose', 
'https://developer.okta.com/blog/2018/12/20/crud-app-with-python-flask-react', NOW()::timestamp, NOW()::timestamp, 1);

insert into source_tag (source_id, tag_id)
values (1, 9),
        (1, 1),
        (1, 3),
        (1, 5),
        (1, 6),
        (1, 8);
