--  CREATE a database 
CREATE SCHEMA UNIVERSITY_DATABASE;

-- Create Student table
CREATE TABLE STUDENT(
NAME VARCHAR(30),
STUDENT_NUMBER SMALLINT UNIQUE,
CLASS SMALLINT,
MAJOR VARCHAR(10),
PRIMARY KEY (STUDENT_NUMBER)
);


-- Create course table
CREATE TABLE COURSE(
COURSE_NAME VARCHAR(30) UNIQUE NOT NULL,
COURSE_NUMBER VARCHAR(30) UNIQUE,
CREDIT_HOURS INT NOT NULL,
DEPARTMENT VARCHAR(10),
PRIMARY KEY (COURSE_NUMBER)
);


-- Create section table(
CREATE TABLE SECTION(
SECTION_IDENTIFIER INT,
COURSE_NUMBER VARCHAR(30),
YEAR CHAR(2) NOT NULL,
SEMESTER VARCHAR(10) NOT NULL,
INSTRUCTOR VARCHAR(20) NOT NULL,
PRIMARY KEY (SECTION_IDENTIFIER),
FOREIGN KEY (COURSE_NUMBER) 
		REFERENCES COURSE (COURSE_NUMBER) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create grade table
CREATE TABLE GRADE_REPORT(
STUDENT_NUMBER SMALLINT,
SECTION_IDENTIFIER INT,
GRADE CHAR(1) NOT NULL,
PRIMARY KEY (STUDENT_NUMBER,SECTION_IDENTIFIER),
FOREIGN KEY (STUDENT_NUMBER) 
		REFERENCES STUDENT (STUDENT_NUMBER) 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
FOREIGN KEY (SECTION_IDENTIFIER) 
		REFERENCES SECTION (SECTION_IDENTIFIER) 
        ON DELETE CASCADE
        ON UPDATE CASCADE        
);

-- Create prerequisite table
CREATE TABLE PREREQUISITE(
COURSE_NUMBER VARCHAR(30),
PREREQUISITE_NUMBER VARCHAR(30),
PRIMARY KEY (COURSE_NUMBER,PREREQUISITE_NUMBER),
FOREIGN KEY (COURSE_NUMBER) 
		REFERENCES COURSE (COURSE_NUMBER) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- insert values to tables
INSERT INTO STUDENT (NAME, STUDENT_NUMBER, CLASS, MAJOR) VALUES 
					('Smith', 17,1,'CS'), 
					('Brown', 8, 1, 'CS');
            

INSERT INTO COURSE (COURSE_NAME, COURSE_NUMBER, CREDIT_HOURS, DEPARTMENT) VALUES 
					('Into to Computer Science', 'CS1310',4,'CS'), 
					('Data Structure', 'CS3320', 4, 'CS'),
                    ('Discrete Mathematics', 'MATH2410', 3, 'MATH'),
                    ('Database', 'CS3380', 3, 'CS');

INSERT INTO SECTION (SECTION_IDENTIFIER, COURSE_NUMBER, SEMESTER, YEAR, INSTRUCTOR) VALUES 
					(85,'MATH2410', 'Fall','07','King'), 
					(92,'CS1310', 'Fall','07','Anderson'), 
                    (102,'CS3320', 'Spring','08','Knuth'), 
                    (112,'MATH2410', 'Fall','08','Chang'), 
                    (119,'CS1310', 'Fall','08','Anderson'), 
                    (135,'CS3380', 'Fall','08','Stone'); 
                    
INSERT INTO GRADE_REPORT (STUDENT_NUMBER,SECTION_IDENTIFIER,GRADE) VALUES    
					(17,112,'B'),
                    (17,119,'C'),
                    (8,85,'A'),
                    (8,92,'A'),
                    (8,102,'B'),
                    (8,135,'A');

INSERT INTO PREREQUISITE (COURSE_NUMBER, PREREQUISITE_NUMBER) VALUES
						('CS3380', 'CS3320'),
                        ('CS3380', 'MATH2410'),
						('CS3320', 'CS1310');
                        


                        
-- Insert a new student, <‘Johnson’, 25, 1, ‘Math’>, in the database
INSERT INTO STUDENT (NAME, STUDENT_NUMBER, CLASS, MAJOR) VALUES 
					('Johnson', 25, 1, 'Math'); 

-- Change the class of student ‘Smith’ to 2
UPDATE STUDENT
SET Class = 2
WHERE Student_number = 17;

-- Insert a new course, <‘Knowledge Engineering’, ‘CS4390’, 3, ‘CS’>
INSERT INTO COURSE (COURSE_NAME, COURSE_NUMBER, CREDIT_HOURS, DEPARTMENT) VALUES 
					('Knowledge Engineering', 'CS4390',3,'CS');

-- Delete the record for the student whose name is ‘Smith’ and whose student number is 17. 
DELETE FROM STUDENT
WHERE NAME = 'Smith'
AND Student_number = 17;


-- Retrieve the prerequisite courses of CS3380.
SELECT PREREQUISITE_NUMBER
FROM PREREQUISITE
WHERE Course_number = 'CS3380';

-- Retrieve the total credit hours offered by CS department. 
SELECT SUM(CREDIT_HOURS)
FROM COURSE
WHERE Department = 'CS';

-- Retrieve the courses that offered in year '08'. Order the results in descending order. 
SELECT DISTINCT COURSE_NUMBER
FROM SECTION
WHERE Year = '08'
ORDER BY Course_number DESC;

-- Count how many 'A's the student with student number 8 has earned.
SELECT Grade, COUNT(*)
FROM GRADE_REPORT
WHERE Student_number = 8 AND Grade = 'A';




