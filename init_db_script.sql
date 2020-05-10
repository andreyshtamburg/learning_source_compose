te table sources (
    "id"           serial,
    "name"         varchar(128) not null,
    "description"  varchar(1024),
    "link"         varchar(256),
    "created_at"   timestamp   not null default current_timestamp,
    "last_updated" timestamp   not null default current_timestamp,
    constraint source_id_pkey primary key (id)
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

insert into sources (name, description, link, created_at, last_updated)
values ('CRUD app with mongo and flask', 'Okta developer explains how to create a simple CRUD app using flask, mongodb, docker-compose', 
'https://developer.okta.com/blog/2018/12/20/crud-app-with-python-flask-react', NOW()::timestamp, NOW()::timestamp);

insert into source_tag (source_id, tag_id)
values (1, 9),
        (1, 1),
        (1, 3),
        (1, 5),
        (1, 6),
        (1, 8);
