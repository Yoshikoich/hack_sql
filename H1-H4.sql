H-1

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);

H-2

insert into countries (name) values ('argentina') , ('colombia'),('chile');
select * from countries;

insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;

delete from users where email = 'bar@bar.com';

update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;

select * from users inner join  countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name 
  from users u inner join  countries c on u.id_country = c.id_country;
  
H-3

CREATE TABLE priorities (
  id_priority SERIAL PRIMARY KEY,
  type_name VARCHAR(50) NOT NULL
);

CREATE TABLE contact_request (
  id_email SERIAL PRIMARY KEY,
  id_country INTEGER NOT NULL,
  id_priority INTEGER,
  name VARCHAR(50) NOT NULL,
  detail TEXT,
  physical_address VARCHAR(255),
  FOREIGN KEY (id_country) REFERENCES countries (id_country),
  FOREIGN KEY (id_priority) REFERENCES priorities (id_priority)
);


H-4

INSERT INTO priorities (type_name) VALUES ('High'), ('Medium'), ('Low');

INSERT INTO countries (name) VALUES
  ('venezuela'),
  ('peru'),
  ('bolivia'),
  ('mexico'),
  ('ecuador');
  
INSERT INTO contact_request (id_country, id_priority, name, detail, physical_address) 
VALUES 
  (1, 1, 'Felipe M', 'Detalles Felipe', 'Av. Olivos 4109, Argentina'),
  (2, 2, 'Laura S', 'Detalles Laura', 'Avenida Calle 26 No 59-51, Colombia'),
  (3, 3, 'Mateo J', 'Detalles Mateo', 'Santa María 2670, Chile');
SELECT * FROM contact_request;

DELETE FROM users 
WHERE id_users = (SELECT MAX(id_users) FROM users);

agregando usuarios de nuevo para poder actualizar
insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
  
UPDATE users
SET email = 'nuevo@correo.com', 
    name = 'nuevo'
WHERE id_users = (SELECT MIN(id_users) FROM users);






  
  
  