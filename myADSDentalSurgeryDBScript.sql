drop table if exists address cascade;
drop table if exists appointment cascade;
drop table if exists dentist cascade;
drop table if exists patient cascade;
drop table if exists surgerylocation cascade;

CREATE TABLE address (
	id int NOT NULL,
  	street varchar NULL,
	state varchar NULL,
	city varchar NULL,
	zipcode int NULL,
	PRIMARY KEY (id)
);


CREATE TABLE dentist (
  	id int NOT NULL,
	firstname varchar NULL,
	lastname varchar NULL,
	contactphone varchar NULL,
	email varchar NULL,
	specialization varchar NULL,
	PRIMARY KEY (id)
);


CREATE TABLE patient (
	id int NOT NULL,
	firstname varchar NULL,
	lastname varchar NULL,
	phone varchar NULL,
	email varchar NULL,
	dob date NULL,
	a_id int,
	PRIMARY KEY (id),
	FOREIGN KEY (a_id) REFERENCES address(id)
);


CREATE TABLE surgerylocation (
	id int NOT NULL,
	"name" varchar NULL,
	phonenumber varchar NULL,
	a_id int,
	PRIMARY KEY (id),
	FOREIGN KEY (a_id) REFERENCES address(id)
);

CREATE TABLE appointment (
	id int NOT NULL,
	appdate date NULL,
	"location" varchar NULL,
	status varchar NULL,
	a_id int,
	d_id int,
	p_id int,
	PRIMARY KEY (id),
	FOREIGN KEY (a_id) REFERENCES address(id),
	FOREIGN KEY (d_id) REFERENCES dentist(id),
	FOREIGN KEY (p_id) REFERENCES patient(id)
);


-----------------------------------------------------------------------------------------

-- Dummy data for address table
INSERT INTO address (id, street, state, city, zipcode)
VALUES 
    (1, '1000 N 4th Street', 'IA', 'Fairfield', 52557),
    (2, '456 Elm St', 'NY', 'New York', 10001),
    (3, '789 Oak St', 'TX', 'Austin', 77001);

-- Dummy data for dentist table
INSERT INTO dentist (id, firstname, lastname, contactphone, email, specialization)
VALUES 
    (1, 'Abel', 'Seyoum', '240-398-7712', 'abelseleshi.seyoum@miu.edu', 'General Dentistry'),
    (2, 'Jane', 'Smith', '987-654-3210', 'jane.smith@example.com', 'Orthodontics');

-- Dummy data for patient table
INSERT INTO patient (id, firstname, lastname, phone, email, dob, a_id)
VALUES 
    (1, 'Alice', 'Johnson', '111-222-3333', 'alice.johnson@example.com', '1985-05-10',1),
    (2, 'Bob', 'Williams', '444-555-6666', 'bob.williams@example.com', '1978-12-15',3);

-- Dummy data for surgerylocation table
INSERT INTO surgerylocation (id, "name", phonenumber, a_id)
VALUES 
    (1, 'City Dental Clinic', '555-123-4567',2),
    (2, 'Town Orthodontics Center', '555-987-6543',2);

-- Dummy data for appointment table
INSERT INTO appointment (id, appdate, location, status, a_id, d_id, p_id)
VALUES 
    (1, '2024-04-10', 'City Dental Clinic', 'Scheduled', 2, 1, 1),
    (2, '2024-04-12', 'Town Orthodontics Center', 'Scheduled', 2, 1, 2);


-------------------------------------------------------------------------------

-- 1. Display the list of ALL Dentists registered in the system, sorted in ascending order of their lastNames
SELECT * FROM Dentist ORDER BY lastname  ASC;

-- 2. Display the list of ALL Appointments for a given Dentist by their dentist_Id number. Include in the result, the Patient information.
SELECT A.*, P.firstname  AS patient_first_name, P.lastname  AS patient_last_name
FROM Appointment A
JOIN Patient P ON A.p_id  = P.id 
JOIN dentist d ON A.d_id = d.id 
WHERE A.d_id = d.id;


-- 3. Display the list of ALL Appointments that have been scheduled at a Surgery Location
SELECT * FROM Appointment WHERE location = 'City Dental Clinic';

-- 4. Display the list of the Appointments booked for a given Patient on a given Date.
SELECT * 
FROM Appointment A
JOIN patient p on a.p_id  = p.id 
WHERE appdate  = '2024-04-10';
