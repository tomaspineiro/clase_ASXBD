
create database vendedores;

use vendedores;

CREATE TABLE sales_persons(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	email VARCHAR(50),
	contact_no VARCHAR(30)
);

INSERT INTO `sales_persons` (`id`, `name`, `email`, `contact_no`) VALUES 
(NULL, 'Kamal Hasan', 'kamal@gmail.com', '0191275634'),
(NULL, 'Nila Hossain', 'nila@gmail.com', '01855342357'),
(NULL, 'Abir Hossain', 'abir@yahoo.com', '01634235698');

CREATE TABLE sales(
	id INT NOT NULL PRIMARY KEY,
	sales_date DATE NOT NULL,
	amount INT,
	sp_id int,
	CONSTRAINT fk_sp FOREIGN KEY (sp_id)
	REFERENCES sales_persons(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `sales` (`id`, `sales_date`, `amount`, `sp_id`) VALUES
('90', '2021-11-09', '800000', '1'),
('34', '2020-12-15', '5634555', '3'),
('67', '2021-12-23', '900000', '1'),
('56', '2020-12-31', '6700000', '1');

