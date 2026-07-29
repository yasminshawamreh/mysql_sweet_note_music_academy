-- Yasmin Shawamreh - DBA210 Final Project - Sweet Note Music Academy (sn)


DROP DATABASE IF EXISTS yasminshawamreh_sn;
CREATE DATABASE yasminshawamreh_sn;
USE yasminshawamreh_sn;


-- Tables

CREATE TABLE instruments (
  instrument_id INT PRIMARY KEY AUTO_INCREMENT,
  instrument_name VARCHAR(255) NOT NULL,
  instrument_description VARCHAR(255) NOT NULL
);

CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  instrument_id INT NOT NULL,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  student_age INT NOT NULL,
  email_address VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(50) NOT NULL,
  CONSTRAINT students_fk_instruments
    FOREIGN KEY (instrument_id)
    REFERENCES instruments (instrument_id)
);

CREATE TABLE instructors (
  instructor_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  email_address VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(50) NOT NULL
);

CREATE TABLE financier (
  financier_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  email_address VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(50) NOT NULL,
  cc_info VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE financier_students (
  financier_students INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  financier_id INT NOT NULL,
  CONSTRAINT financier_students_fk_students
    FOREIGN KEY (student_id)
    REFERENCES students (student_id),
  CONSTRAINT financier_students_fk_financier
    FOREIGN KEY (financier_id)
    REFERENCES financier (financier_id)
);

CREATE TABLE instructor_instruments (
  ii_id INT PRIMARY KEY AUTO_INCREMENT,
  instructor_id INT NOT NULL,
  instrument_id INT NOT NULL,
  CONSTRAINT instructor_instruments_fk_instructors
    FOREIGN KEY (instructor_id)
    REFERENCES instructors (instructor_id),
  CONSTRAINT instructor_instruments_fk_instruments
    FOREIGN KEY (instrument_id)
    REFERENCES instruments (instrument_id)
);

CREATE TABLE music_lessons (
  mlesson_id INT PRIMARY KEY AUTO_INCREMENT,
  mlesson_name VARCHAR(255) NOT NULL,
  mlesson_appointment DATETIME NOT NULL,
  student_id INT NOT NULL,
  instructor_id INT NOT NULL,
  CONSTRAINT music_lessons_fk_students
    FOREIGN KEY (student_id)
    REFERENCES students (student_id),
  CONSTRAINT music_lessons_fk_instructors
    FOREIGN KEY (instructor_id)
    REFERENCES instructors (instructor_id)
);

CREATE TABLE sweet_note_packs (
  snpacks_id INT PRIMARY KEY AUTO_INCREMENT,
  snpacks_name VARCHAR(255) NOT NULL,
  snpacks_price DECIMAL(9,2) NOT NULL,
  lessons_per_pack INT NOT NULL 
);

CREATE TABLE invoices (
  invoice_id INT PRIMARY KEY AUTO_INCREMENT,
  financier_id INT NOT NULL,
  invoice_number VARCHAR(255) UNIQUE NOT NULL,
  invoice_date DATE NOT NULL,
  invoice_total DECIMAL(9,2) NOT NULL,
  payment_total DECIMAL(9,2) NOT NULL,
  credit_total DECIMAL(9,2) NOT NULL,
  invoice_due_date DATE NOT NULL,
  payment_date DATE NOT NULL,
  CONSTRAINT invoices_fk_financier
    FOREIGN KEY (financier_id)
    REFERENCES financier (financier_id)
);

CREATE TABLE invoice_packages (
  ipacks_id INT PRIMARY KEY AUTO_INCREMENT,
  invoice_id INT NOT NULL,
  snpacks_id INT NOT NULL,
  CONSTRAINT invoice_packages_fk_invoices
    FOREIGN KEY (invoice_id)
    REFERENCES invoices (invoice_id),
  CONSTRAINT invoice_packages_fk_sweet_note_packs
    FOREIGN KEY (snpacks_id)
    REFERENCES sweet_note_packs (snpacks_id)
);

CREATE TABLE performance_venues (
  pvenue_id INT PRIMARY KEY AUTO_INCREMENT,
  pvenue_name VARCHAR(255) NOT NULL,
  pvenue_address VARCHAR(255) NOT NULL,
  pvenue_city VARCHAR(50) NOT NULL,
  pvenue_state VARCHAR(2) NOT NULL,
  pvenue_zip_code VARCHAR(20) NOT NULL,
  pvenue_phone VARCHAR(50)
);

CREATE TABLE performance_reviews (
  previews_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  instructor_id INT NOT NULL,
  pvenue_id INT NOT NULL,
  preview_date DATE NOT NULL,
  pr_grade DECIMAL(9,2) NOT NULL DEFAULT 0,
  grade_description VARCHAR(255) NOT NULL,
  CONSTRAINT performance_reviews_fk_students
    FOREIGN KEY (student_id)
    REFERENCES students (student_id),
  CONSTRAINT performance_reviews_fk_instructors
    FOREIGN KEY (instructor_id)
    REFERENCES instructors (instructor_id),
  CONSTRAINT performance_reviews_fk_performance_venues
    FOREIGN KEY (pvenue_id)
    REFERENCES performance_venues (pvenue_id)
);



-- Indexes

CREATE INDEX invoices_invoice_date_ix
ON invoices (invoice_date DESC);

CREATE INDEX invoices_invoice_total_ix
ON invoices (invoice_total DESC);



-- Data

INSERT INTO instruments VALUES
(1, 'Piano', 'A large keyboard musical instrument.'),
(2, 'Violin', 'A string instrument played with a bow.'),
(3, 'Guitar', 'A fretted musical instrument with six strings.'),
(4, 'Voice', 'The human voice used as a musical instrument for singing.'),
(5, 'Drums', 'A percussion instrument typically played by striking with sticks or hands.'),
(6, 'Flute', 'A woodwind instrument played by blowing air.'),
(7, 'Saxophone', 'A brass woodwind instrument played with a single-reed mouthpiece.'),
(8, 'Cello', 'A large string instrument played upright and supported by the floor.'),
(9, 'Bass Guitar', 'A large string instrument played upright and supported by the floor.'),
(10, 'Clarinet', 'A single-reed woodwind instrument with a cylindrical shape.');

INSERT INTO students VALUES
(1, 4, 'Emma', 'Goodman', '17', 'emma.johnson@gmail.com', '828-123-4567'),
(2, 5, 'Liam', 'Sommers', '10', 'lsommers@gmail.com', '828-987-6543'),
(3, 6, 'Olivia', 'Brown', '21', 'brownOlivia91@gmail.com', '828-555-1131'),
(4, 3, 'Noah', 'Abdullah', '45', 'nabdullah@gmail.com', '828-222-3346'),
(5, 4, 'Eva', 'Martinez', '12', 'eva.martinez@gmail.com', '828-494-5415'),
(6, 8, 'Elijah', 'Garcia', '67', 'elijahG33@gmail.com', '828-649-7747'),
(7, 9, 'Amina', 'Hassan', '30', 'ahassan2@gmail.com', '828-101-2029'),
(8, 10, 'James', 'Anderson', '18', 'jamesAnderson@gmail.com', '828-000-1234'),
(9, 2, 'Isabella', 'Thomas', '12', 'isabella.thomas@gmail.com', '828-321-4321'),
(10, 7, 'Zahra', 'Abdi', '11', 'zahraabdi@gmail.com', '828-919-0202'),
(11, 3, 'Ali', 'Abdi', '13', 'aliabdi@gmail.com', '828-338-2848');

INSERT INTO instructors VALUES
(1, 'Jamal', 'Washington', 'jamal.washington@gmail.com', '828-104-2121'),
(2, 'Hyeon', 'Parker', 'teacherparker1@gmail.com', '829-313-4341'),
(3, 'Leah', 'Dubois', 'duboisl@gmail.com', '828-515-6161'),
(4, 'Raj', 'Patel', 'patelraj@gmail.com', '828-583-9883'),
(5, 'Fatima', 'Al-Farsi', 'alfarsif2@gmail.com', '828-003-5839'),
(6, 'Mei', 'Chen', 'chenmei249@gmail.com', '828-274-8893');

INSERT INTO financier VALUES
(1, 'Grace', 'Goodman', 'ggoodman@gmail.com', '828-301-4020', 'XXXX-XXXX-XXXX-3421'),
(2, 'Katherine', 'Sommers', 'sommeryK@gmail.com', '828-212-3122', 'XXXX-XXXX-XXXX-8765'),
(3, 'Nadia', 'Brown', 'brownNadia2@gmail.com', '828-332-3234', 'XXXX-XXXX-XXXX-1122'),
(4, 'Noah', 'Abdullah', 'nabdullah@gmail.com', '828-222-3346', 'XXXX-XXXX-XXXX-3143'),
(5, 'Linda', 'Martinez', 'lindalinda242@gmail.com', '828-903-3837', 'XXXX-XXXX-XXXX-6677'),
(6, 'Elijah', 'Garcia', 'elijahG33@gmail.com', '828-649-7747', 'XXXX-XXXX-XXXX-5566'),
(7, 'Amina', 'Hassan', 'ahassan2@gmail.com', '828-101-2029', 'XXXX-XXXX-XXXX-5344'),
(8, 'Anastasia', 'Petrova', 'apetrova@gmail.com', '828-112-2233', 'XXXX-XXXX-XXXX-7788'),
(9, 'Samuel', 'Thomas', 'thomasSam@aol.com', '828-483-3882', 'XXXX-XXXX-XXXX-5392'),
(10, 'Omar', 'Abdi', 'abdiomar@yahoo.com', '828-299-4893', 'XXXX-XXXX-XXXX-3927');

INSERT INTO financier_students VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 10);

INSERT INTO instructor_instruments VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 5),
(5, 2, 6),
(6, 2, 10),
(7, 3, 1),
(8, 3, 4),
(9, 4, 5),
(10, 4, 7),
(11, 5, 2),
(12, 5, 8),
(13, 6, 9);

INSERT INTO music_lessons VALUES
(1, 'Voice', '2025-08-05 12:30:00', 1, 3),
(2, 'Drums', '2025-08-05 1:30:00', 2, 4),
(3, 'Flute', '2025-08-12 1:30:00', 3, 2),
(4, 'Guitar', '2025-08-10 3:30:00', 4, 1),
(5, 'Voice', '2025-08-20 12:30:00', 5, 3),
(6, 'Cello', '2025-08-06 2:30:00', 6, 5),
(7, 'Bass Guitar', '2025-08-06 1:30:00', 7, 6),
(8, 'Clarinet', '2025-08-04 12:30:00', 8, 2),
(9, 'Violin', '2025-08-04 2:30:00', 9, 5),
(10, 'Saxophone', '2025-08-13 12:30:00', 10, 4),
(11, 'Guitar', '2025-08-13 1:30:00', 11, 1),
(12, 'Guitar', '2025-08-17 12:30:00', 11, 1),
(13, 'Guitar', '2025-08-22 12:30:00', 11, 1),
(14, 'Bass Guitar', '2025-08-11 12:30:00', 7, 6),
(15, 'Voice', '2025-08-24 12:30:00', 5, 3),
(16, 'Cello', '2025-08-10 1:30:00', 6, 5);

INSERT INTO sweet_note_packs VALUES
(1, 'Quarter Note Pack', '168.00', '3'),
(2, 'Half Note Pack', '250.00', '5'),
(3, 'Whole Note Pack', '450.00', '10');

INSERT INTO invoices VALUES
(1, 2, '812000-399', '2025-08-05', '250.00', '250.00', '0.00', '2025-09-05', '2025-08-10'),
(2, 6, '812000-400', '2025-08-05', '168.00', '168.00', '0.00', '2025-09-05', '2025-08-06'),
(3, 10, '812000-401', '2025-08-10', '900.00', '900.00', '0.00', '2025-09-05', '2025-08-10'),
(4, 8, '812000-402', '2025-08-13', '450.00', '450.00', '0.00', '2025-09-05', '2025-08-13');

INSERT INTO invoice_packages VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 3, 3),
(5, 4, 3);

INSERT INTO performance_venues VALUES
(1, 'The One Stop at Asheville Music Hall', '55 College St', 'Asheville', 'NC', '28801', '828-255-7777'),
(2, 'The Odd', '1045 Haywood Rd', 'Asheville', 'NC', '28806', '828-575-9299'),
(3, 'Asheville Music Hall', '31 Patton Ave', 'Asheville', 'NC', '28801', '828-255-7777'),
(4, 'Sly Gorg Lounge', '271 Haywood St', 'Asheville', 'NC', '28801', '');

INSERT INTO performance_reviews VALUES
(1, 5, 3, 3, '2025-07-10', '95.00', 'Great performance! Slight timing issue on transitions.'),
(2, 1, 3, 1, '2025-07-15',	'85.00',	'Needs more rehearsal. Pitch inconsistencies observed.'),
(3, 4, 3, 4, '2025-06-20', '95.00', 'Nervous start, but improved steadily.'),
(4, 6, 5, 2, '2025-06-10', '100.00', 'Outstanding stage presence.');
