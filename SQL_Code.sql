-- =====================================
-- Database Creation
-- =====================================
CREATE DATABASE hospital16;
USE hospital16;


SELECT patients.PatientID,patients.Name, patients.Age, patients.Gender, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM patients
LEFT JOIN visits
ON patients.PatientID = visits.PatientID
WHERE visits.`Admission Type` = "Emergency";
-- =====================================
-- Analytical Queries
-- =====================================

SELECT billing.VisitID, billing.Doctor, billing.Hospital, billing.`Insurance Provider`, 
sum(billing.`Billing Amount`) as debt, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM billing
LEFT JOIN visits
ON billing.VisitID = visits.VisitID
GROUP BY billing.VisitID, visits.PatientID
ORDER BY debt;

SELECT patients.PatientID,patients.Name, patients.Age, patients.Gender, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM patients
LEFT JOIN visits
ON patients.PatientID = visits.PatientID
WHERE patients.Name like '%e%';

SELECT patients.PatientID,patients.Name, patients.Age, patients.Gender, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM patients
LEFT JOIN visits
ON patients.PatientID = visits.PatientID
WHERE patients.Age BETWEEN 18 and 25;

SELECT billing.VisitID, billing.Doctor, billing.Hospital, billing.`Insurance Provider`, 
billing.`Billing Amount`, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM billing
LEFT JOIN visits
ON billing.VisitID = visits.VisitID
WHERE billing.`Insurance Provider` IN ("UnitedHealthcare", "Blue Cross", "Medicare");


-- =====================================
-- Stored Procedures
-- =====================================
USE hospital16;
DROP PROCEDURE IF EXISTS highDebt;

DROP PROCEDURE IF EXISTS DateBetween$$;


DELIMITER $$
USE `hospital16`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DatesBetween`()
BEGIN
SELECT patients.Name, patients.PatientID, patients.Age, patients.Gender, patients.`Medical Condition`,
visits.`Date of Admission`, visits.VisitID,
billing.VisitID
FROM patients
LEFT JOIN visits
ON patients.PatientID=visits.PatientID
LEFT JOIN billing
ON visits.VisitID=billing.VisitID
WHERE visits.`Date of Admission` BETWEEN '2019-01-01' AND '2021-12-31';
END$$
DELIMITER ;
CALL DatesBetween();


DELIMITER $$
USE `hospital16`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `highDebt`()
BEGIN
SELECT patients.Name, patients.PatientID, patients.Age, patients.Gender, patients.`Medical Condition`,
visits.`Date of Admission`, visits.VisitID, billing.`Billing Amount`,
billing.VisitID
FROM patients
LEFT JOIN visits
ON patients.PatientID=visits.PatientID
LEFT JOIN billing
ON visits.VisitID=billing.VisitID
WHERE billing.`Billing Amount` > 1000;
END$$
DELIMITER ;
CALL highDebt();

-- =====================================
-- Triggers
-- =====================================

DELIMITER //
CREATE TRIGGER ErrorMessage
BEFORE INSERT ON patients FOR EACH ROW
BEGIN
IF NEW.Age <18 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'Patient is Not a Legal Adult';
END IF;
END;
//
SHOW TRIGGERS;

INSERT INTO patients (Name, PatientID, Age, Gender)
VALUES ('YTony', '09877654', '16', 'Male');

DROP TRIGGER IF EXISTS NewInsurance;


DELIMITER //
CREATE TRIGGER NewInsurance
BEFORE INSERT ON billing
FOR EACH ROW
IF NEW.`Insurance Provider` = "Aetna" THEN SET NEW.`Insurance Provider` = "Obama Care";
END IF;//

SELECT * FROM billing;
SHOW TRIGGERS;
