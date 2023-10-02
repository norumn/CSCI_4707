-- Scenario 1
-- Entities
CREATE TABLE Professor (
    staff_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    GPA FLOAT
);

-- Relationships
CREATE TABLE Teaches (
    staff_id INT,
    course_id INT,
    PRIMARY KEY(staff_id, course_id),
    FOREIGN KEY(staff_id) REFERENCES Professor(staff_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE Registration (
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    PRIMARY KEY(student_id, course_id, semester),
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

-- Scenario 2
-- Relationships
CREATE TABLE Teaches (
    -- ... remains same as Scenario 1
);

CREATE TABLE LastRegistration (
    student_id INT,
    course_id INT,
    semester VARCHAR(10) NOT NULL,
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

-- Scenario 3
-- New Entity for Category
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    super_category_id INT,  -- for the hierarchy
    FOREIGN KEY(super_category_id) REFERENCES Category(category_id)
);

-- Updating Course to have category reference
ALTER TABLE Course ADD category_id INT;
ALTER TABLE Course ADD FOREIGN KEY (category_id) REFERENCES Category(category_id);

-- Scenario 4
-- Entities
CREATE TABLE Undergraduate (
    student_id INT PRIMARY KEY,
    year INT NOT NULL,
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE Graduate (
    student_id INT PRIMARY KEY,
    research_area VARCHAR(100),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

-- Relationships
CREATE TABLE Advises (
    staff_id INT,
    graduate_id INT,
    PRIMARY KEY(staff_id, graduate_id),
    FOREIGN KEY(staff_id) REFERENCES Professor(staff_id),
    FOREIGN KEY(graduate_id) REFERENCES Graduate(student_id)
);

-- Scenario 5
-- New Entity for Project
CREATE TABLE Project (
    project_id INT,
    project_name VARCHAR(100),
    owner_id INT,
    PRIMARY KEY(project_id, project_name),
    FOREIGN KEY(owner_id) REFERENCES Professor(staff_id)
);

-- Update Graduate for Project
ALTER TABLE Graduate ADD project_id INT;
ALTER TABLE Graduate ADD FOREIGN KEY (project_id) REFERENCES Project(project_id);
