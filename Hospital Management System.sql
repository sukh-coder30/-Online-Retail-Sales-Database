Create DATABASE HospitalDB;
USE HospitalDB;
CREATE TABLE patients(
patients_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
age INT ,
gender ENUM('Male', 'Female', 'Other'),
contact VARCHAR(50),
admission_date DATE,
discharge_date DATE,
status VARCHAR(100));
INSERT INTO Patients (name, age, gender, contact, admission_date, status) VALUES
('John Doe', 45, 'Male', '9811122233', '2025-07-20', 'Admitted'),
('Anita Kumari', 34, 'Female', '9822233445', '2025-07-22', 'Admitted');
SELECT * FROM Patients;

CREATE TABLE doctors(
doctor_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
specialization VARCHAR(50),
contact VARCHAR(20));

INSERT INTO doctors (name, specialization, contact) VALUES
('Dr. A Sharma', 'Cardiology', '9876543210'),
('Dr. B Mehta', 'Neurology', '9876543211'),
('Dr. C Verma', 'Orthopedics', '9876543212');

SELECT * FROM doctors;

CREATE TABLE visit(
visit_id INT AUTO_INCREMENT PRIMARY KEY,
patients_id INT,
doctor_id INT,
visit_date DATE,
reason VARCHAR(255),
diagnosis TEXT,
FOREIGN KEY(patients_id) REFERENCES patients(patients_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id));

INSERT INTO Visit (patients_id, doctor_id, visit_date, reason, diagnosis) VALUES
(1, 1, '2025-07-21', 'Chest pain', 'Mild heart condition'),
(2, 2, '2025-07-23', 'Headache', 'Migraine');

CREATE TABLE bills(
bill_id  INT AUTO_INCREMENT PRIMARY KEY,
visit_id INT,
bill_date DATE,
amount DECIMAL(10,2),
paid BOOLEAN DEFAULT FALSE,
FOREIGN KEY(visit_id) REFERENCES visit(visit_id));

INSERT INTO bills (visit_id, bill_date, amount, paid) VALUES
(1, '2025-07-21', 3000.00, TRUE),
(2, '2025-07-23', 2500.00, FALSE);

SELECT * FROM BILLS;

-- 3. Useful Queries
-- List All Appointments:

SELECT v.visit_id, p.name AS patients, d.name AS doctors, v.visit_date, v.reason 
FROM visit v
JOIN patients p ON v.patients_id= p.patients_id
JOIN doctors d ON v.doctor_id=d.doctor_id;

-- Unpaid Bills
SELECT b.bill_id, p.name as Patients, b.amount, b.bill_date
from bills b 
join visit v on b.visit_id=v.visit_id
join patients p on v.patients_id=p.patients_id
where b.paid=False;

-- 4. Stored Procedure: Billing Calculation
DELIMITER //

create procedure calculatebillng(In VisitID int, IN baseAmount Decimal(10,2))
BEGIN
	Declare totalAmount Decimal(10,2);
    Set totalAmount=baseAmount +(baseAmount *0.18);
    insert into bills (visit_id, bill_date, amount, paid)
    values(visitID, curdate(), totalAmount, false);
END//

DELIMITER ;

CALL Calculatebillng(2, 2000);

-- Triggers
-- Auto-update status on discharge:

DELIMITER //
CREATE trigger update_status_after_discharge
before update on patients
for each row 
begin
	IF new.discharge_date Is not null Then 
		Set new.status='Discharge';
	end if;
End //

DELIMITER ;

UPDATE Patients
SET discharge_date = '2025-07-24'
WHERE patients_id = 1;

select * from Patients;

-- Generate visit Report 

select 
p.name as patients_name,
d.name as doctor_name,
v.visit_date,
v.reason,
v.diagnosis,
b.amount,
b.paid
from Visit v
join patients p on v.patients_id=p.patients_id
join Doctors d on v.doctor_id=d.doctor_id
left join bills b on v.visit_id= b.visit_id;
