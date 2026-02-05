-- =============================================
-- Oracle Database Schema for Training Portal
-- =============================================

-- Drop existing tables if they exist
DROP TABLE enrollments CASCADE CONSTRAINTS;
DROP TABLE courses CASCADE CONSTRAINTS;
DROP TABLE students CASCADE CONSTRAINTS;

-- Drop sequences if they exist
DROP SEQUENCE student_seq;
DROP SEQUENCE course_seq;
DROP SEQUENCE enrollment_seq;

-- =============================================
-- Create Students Table
-- =============================================
CREATE TABLE students (
    student_id NUMBER(10) PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    course VARCHAR2(100),
    registration_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT chk_status CHECK (status IN ('active', 'inactive', 'suspended'))
);

-- Create sequence for student_id
CREATE SEQUENCE student_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Create trigger for auto-increment
CREATE OR REPLACE TRIGGER student_id_trigger
    BEFORE INSERT ON students
    FOR EACH ROW
BEGIN
    IF :NEW.student_id IS NULL THEN
        SELECT student_seq.NEXTVAL INTO :NEW.student_id FROM DUAL;
    END IF;
END;
/

-- =============================================
-- Create Courses Table
-- =============================================
CREATE TABLE courses (
    course_id NUMBER(10) PRIMARY KEY,
    course_name VARCHAR2(200) NOT NULL,
    description VARCHAR2(1000),
    duration VARCHAR2(50),
    mode VARCHAR2(50),
    certification VARCHAR2(10) DEFAULT 'Yes',
    instructor VARCHAR2(100),
    price NUMBER(10,2),
    status VARCHAR2(20) DEFAULT 'active',
    created_date DATE DEFAULT SYSDATE,
    CONSTRAINT chk_course_status CHECK (status IN ('active', 'inactive'))
);

-- Create sequence for course_id
CREATE SEQUENCE course_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Create trigger for auto-increment
CREATE OR REPLACE TRIGGER course_id_trigger
    BEFORE INSERT ON courses
    FOR EACH ROW
BEGIN
    IF :NEW.course_id IS NULL THEN
        SELECT course_seq.NEXTVAL INTO :NEW.course_id FROM DUAL;
    END IF;
END;
/

-- =============================================
-- Create Enrollments Table
-- =============================================
CREATE TABLE enrollments (
    enrollment_id NUMBER(10) PRIMARY KEY,
    student_id NUMBER(10) NOT NULL,
    course_id NUMBER(10) NOT NULL,
    enrollment_date DATE DEFAULT SYSDATE,
    completion_status VARCHAR2(20) DEFAULT 'enrolled',
    completion_date DATE,
    grade VARCHAR2(5),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id),
    CONSTRAINT chk_completion_status CHECK (completion_status IN ('enrolled', 'in-progress', 'completed', 'dropped'))
);

-- Create sequence for enrollment_id
CREATE SEQUENCE enrollment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Create trigger for auto-increment
CREATE OR REPLACE TRIGGER enrollment_id_trigger
    BEFORE INSERT ON enrollments
    FOR EACH ROW
BEGIN
    IF :NEW.enrollment_id IS NULL THEN
        SELECT enrollment_seq.NEXTVAL INTO :NEW.enrollment_id FROM DUAL;
    END IF;
END;
/

-- =============================================
-- Insert Sample Courses Data
-- =============================================
INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('AWS DevOps Training', 'Master cloud computing and DevOps practices with AWS services including EC2, S3, Lambda, CloudFormation, and CI/CD pipelines.', 
        '60 Hours', 'Online/Classroom', 'Yes', 'John Smith', 15000, 'active');

INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('Python Full Stack Development', 'Comprehensive training on Python, Django, Flask, React, databases, and deployment. Build complete web applications.', 
        '90 Hours', 'Online/Classroom', 'Yes', 'Sarah Johnson', 18000, 'active');

INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('Data Science & Machine Learning', 'Learn Python for data science, ML algorithms, deep learning, NLP, and computer vision with real-world projects.', 
        '80 Hours', 'Online/Classroom', 'Yes', 'Michael Chen', 20000, 'active');

INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('Java Full Stack Development', 'Complete Java training with Spring Boot, Hibernate, Microservices, Angular/React, and enterprise development.', 
        '100 Hours', 'Online/Classroom', 'Yes', 'David Kumar', 19000, 'active');

INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('Azure DevOps Training', 'Master Microsoft Azure cloud services, Azure DevOps, CI/CD pipelines, Kubernetes, and infrastructure automation.', 
        '55 Hours', 'Online/Classroom', 'Yes', 'Emily White', 16000, 'active');

INSERT INTO courses (course_name, description, duration, mode, certification, instructor, price, status)
VALUES ('Salesforce Administrator & Developer', 'Complete Salesforce training covering Admin, Development, Lightning, Apex, Visualforce, and integration.', 
        '70 Hours', 'Online/Classroom', 'Yes', 'Robert Taylor', 17000, 'active');

-- =============================================
-- Insert Sample Student Data (for testing)
-- =============================================
INSERT INTO students (full_name, email, phone, password, course, status)
VALUES ('Test Student', 'test@example.com', '9999999999', 'test123', 'AWS DevOps Training', 'active');

INSERT INTO students (full_name, email, phone, password, course, status)
VALUES ('Demo User', 'demo@example.com', '8888888888', 'demo123', 'Python Full Stack Development', 'active');

-- =============================================
-- Commit the changes
-- =============================================
COMMIT;

-- =============================================
-- Verify data insertion
-- =============================================
SELECT COUNT(*) as total_courses FROM courses;
SELECT COUNT(*) as total_students FROM students;

-- Display all courses
SELECT course_id, course_name, duration, mode FROM courses ORDER BY course_id;

-- Display all students
SELECT student_id, full_name, email, course FROM students ORDER BY student_id;

-- =============================================
-- End of SQL Script
-- =============================================
