CREATE TABLE CERTIFICATION (
    Certification_id int identity(1,1),
    Name varchar NOT NULL
    CONSTRAINT CertificationPK PRIMARY KEY (Certification_id)
);

CREATE TABLE OPERATOR_CERTIFICATION(
    Employee_id int,
    Certification_id int,
    Date_awarded date,
    expiry date,
);

ALTER TABLE OPERATOR_CERTIFICATION
    ALTER COLUMN Employee_id int NOT NULL;

ALTER TABLE OPERATOR_CERTIFICATION
    ALTER COLUMN Certification_id int NOT NULL;

ALTER TABLE OPERATOR_CERTIFICATION
    ADD CONSTRAINT OCCPK PRIMARY KEY (Employee_id,Certification_id),
    CONSTRAINT OCFK1 FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT OCFK2 FOREIGN KEY (Certification_id)
        REFERENCES CERTIFICATION(Certification_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE;

