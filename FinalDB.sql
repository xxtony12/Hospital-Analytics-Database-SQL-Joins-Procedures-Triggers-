CREATE DATABASE hospital16;
USE hospital16;


SELECT patients.PatientID,patients.Name, patients.Age, patients.Gender, visits.VisitID, visits.PatientID, visits.`Admission Type`
FROM patients
LEFT JOIN visits
ON patients.PatientID = visits.PatientID
WHERE visits.`Admission Type` = "Emergency";


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

DROP PROCEDURE IF EXISTS DateBetween$$

-- Part 2
DELIMITER $$
USE `hospital16`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DateBetween`()
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
CALL DateBetween();


DELIMITER $$
USE `week13`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `leftJoin2`()
BEGIN
SELECT Name, Doctor, SUM(InvoiceAMT) AS TotalAMT
FROM patients
LEFT JOIN week13_visit
ON week13_patient.PatientID=week13_visit.PatientID
LEFT JOIN week13_invoice
ON week13_visit.visitID=week13_invoice.visitID
WHERE TotalAmt > 1000;
END$$
DELIMITER ;
CALL leftJoin2();