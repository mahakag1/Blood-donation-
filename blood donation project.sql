CREATE DATABASE blood_donation;
USE blood_donation;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    blood_group VARCHAR(5),
    role VARCHAR(20)
);
CREATE TABLE Donor (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    last_donation_date DATE,
    medical_history TEXT,
    eligibility_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Hospital (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(200),
    contact VARCHAR(15)
);
CREATE TABLE BloodInventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT,
    blood_group VARCHAR(5),
    units_available INT,
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);
CREATE TABLE DonationHistory (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT,
    hospital_id INT,
    date DATE,
    units_donated INT,
    FOREIGN KEY (donor_id) REFERENCES Donor(donor_id),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);
INSERT INTO Users (name, age, gender, phone, email, password, blood_group, role) VALUES
('Rahul Sharma', 25, 'Male', '9876543210', 'rahul@gmail.com', '1234', 'A+', 'donor'),
('Priya Verma', 22, 'Female', '9876501234', 'priya@gmail.com', '1234', 'B+', 'donor'),
('Amit Singh', 30, 'Male', '9876512345', 'amit@gmail.com', '1234', 'O+', 'patient');

INSERT INTO Donor (user_id, last_donation_date, medical_history, eligibility_status) VALUES
(1, '2025-12-01', 'Healthy', 'Eligible'),
(2, '2025-11-15', 'Low BP', 'Not Eligible');

INSERT INTO Hospital (name, location, contact) VALUES
('City Hospital', 'Bhopal', '0755123456'),
('Red Cross Blood Bank', 'Bhopal', '0755987654');

INSERT INTO BloodInventory (hospital_id, blood_group, units_available) VALUES
(1, 'A+', 10),
(1, 'B+', 5),
(2, 'O+', 8);
INSERT INTO Users (name, age, gender, phone, email, password, blood_group, role) VALUES
('Rohit Mehta', 27, 'Male', '9876500001', 'rohit@gmail.com', '1234', 'O-', 'donor'),
('Anjali Singh', 24, 'Female', '9876500002', 'anjali@gmail.com', '1234', 'A-', 'donor'),
('Karan Patel', 29, 'Male', '9876500003', 'karan@gmail.com', '1234', 'B-', 'patient'),
('Neha Jain', 26, 'Female', '9876500004', 'neha@gmail.com', '1234', 'AB+', 'donor'),
('Vikas Yadav', 31, 'Male', '9876500005', 'vikas@gmail.com', '1234', 'O+', 'donor');
INSERT INTO Donor (user_id, last_donation_date, medical_history, eligibility_status) VALUES
(4, '2025-09-10', 'Healthy', 'Eligible'),
(5, '2025-08-15', 'Diabetes', 'Not Eligible'),
(7, '2025-11-01', 'Healthy', 'Eligible'),
(8, '2025-07-20', 'Low Hemoglobin', 'Not Eligible');
INSERT INTO Hospital (name, location, contact) VALUES
('AIIMS Bhopal', 'Bhopal', '0755267890'),
('People Hospital', 'Bhopal', '0755234567'),
('Care Hospital', 'Indore', '0731456789');
INSERT INTO BloodInventory (hospital_id, blood_group, units_available) VALUES
(3, 'A-', 7),
(3, 'O-', 4),
(4, 'B+', 6),
(4, 'AB+', 2),
(5, 'O+', 9),
(5, 'A+', 5);
INSERT INTO DonationHistory (donor_id, hospital_id, date, units_donated) VALUES
(1, 2, '2025-09-01', 1),
(2, 1, '2025-10-10', 1),
(3, 3, '2025-11-01', 2);
SELECT * FROM Users;
SELECT * FROM Donor;
SELECT * FROM Hospital;
SELECT * FROM BloodInventory;
SELECT * FROM DonationHistory;