-- Dropping if exists so I don't get already exists errors
--drop table scores
--drop table studentclasses
--drop table scoreTypes
--drop table students
--drop table classes
--drop database College

-- UNCOMMET ABOVE CODE AS NEEDED

-- Create the College database
 Create DATABASE College

-- Telling SQL to use the college database
Use College

-- Create students table
Create table students(
studentID INT IDENTITY(1,1) PRIMARY key Not Null,
FName varchar (30) Not Null,
LName varchar (30) Not Null,
SNN int Not Null,
[Address] varchar (30) Not Null,
City varchar (30) Not Null,
[State] varchar (30) Not Null,
Zip int Not Null,
Phone bigint Not Null
)

-- create table for dept types since each student can be in several classes 
Create table deptTypes(
DepartmentTypeID int Identity Primary Key not null,
Type varchar (30) not null
)

-- Create Classes table
Create table classes(
classID int IDENTITY(1,1) PRIMARY key NOT NULL,
Title varchar (30) Not Null,
Number int Not Null,
-- using a foreign key to reference dept types
departmentTypeID int Constraint FK_classes_deptarmentTypeID Foreign Key 
references College.dbo.deptTypes(departmentTypeID) not null
)

-- Create a table for score types since each student can take several different test/quiz/exam
create table scoreTypes(
ScoreTypeID int Identity Primary Key not null,
Type varchar(30) not null
)

-- Create a table for student classes. This table basically merges the two wildcard tables together (classes and score Type)
create table studentClasses(
studentClassID int Identity(1,1) Primary Key not null,
classID int Constraint FK_studentClasses_ClassID Foreign Key references
College.dbo.Classes(classID) not null,
studentID int Constraint FK_studentsClasses_StudentID Foreign Key references
College.dbo.students(studentID) not null
)

-- Create Scores table
Create table scores(
scoreID int IDENTITY(1,1) PRIMARY key NOT NULL,
ScoreTypeID int Constraint FK_Scores_ScoreTypeID Foreign Key References
College.dbo.ScoreTypes(ScoreTypeID) Not Null,
studentClassID int Constraint FK_sCORES_StudentClassID Foreign Key references
College.dbo.StudentClasses(StudentClassID) not null,
[Description] varchar (300) Not Null,
-- I am just going to use date for these rather than datetime becuase i dont want a bunch of 0's at the end.
DateAssigned DATE Not Null,
DateDue DATE Not Null,
DateSubmitted DATE Not Null,
PointsEarned int not Null,
PointsPossible int Not Null
)

-- Populating students table with radom data
INSERT INTO students(FName, LName, SNN, [Address], City, [State], Zip, Phone)
Values ('Sam','Nasr', 111111111, '252 N College Blv', 'Vermillion','Ohio','44332',4196780909),
	   ('John','Doe', 222222222, '56 S Drive', 'Bowling Green','Ohio','44332',4196780909),
	   ('Jane','Doe', 333333333, '59 E Street', 'Vermillion','Ohio','44332',4196780909)

-- Populating DeptTypes with data
insert into deptTypes(Type)
values('Technology'),
	  ('Science'),
	  ('Arts')

-- Populating classes table with radom data
INSERT INTO classes
Values ('Computer Science', 1000, 1),
	   ('Exercise Science', 2000, 2),
	   ('Liberal Arts', 1000, 3)

-- Populating score types with random data
insert into scoreTypes(Type)
values('Test'),
	  ('Quiz'),
      ('Midterm')

-- Populating studentClasses
insert into studentClasses(classID, studentID)
values (1,1),
	   (2,2),
	   (3,3),

-- Populating scores table with radom data
INSERT INTO scores(ScoreTypeID, studentClassID, [Description], DateAssigned, DateDue, DateSubmitted, PointsEarned, PointsPossible)
Values (1,1, 'Intro to programming', '2019-4-11', '2019-4-19', '2019-4-15', 110, 100),
       (2,2, 'Intimate weight lifting', '2019-4-12', '2019-4-20', '2019-4-16', 70,  99),
       (3,3, 'Intro to diversity', '2019-4-13', '2019-4-21', '2019-4-17', 456, 500)

--Selecting everything needed to display my table
--SNN and address are not being output to the final display table (only displaying content relavent to current test/quiz/exam) can add them in later if nessary.
select 
	students.FName as 'First',
	Students.LName as 'Last', 
	classes.title as 'Class', 
	classes.Number as 'level',
	deptTypes.Type as 'College',
	description as Description, 
	scoreTypes.Type, 
	dateAssigned as 'Date Assigned', 
	dateDue as 'Date Due',
	dateSubmitted as 'Date Submitted',
	pointsEarned as 'Points Earned', 
	pointsPossible as 'Points Possible'

-- inner join similar data
from scores
Inner Join studentClasses on scores.studentClassID = studentClasses.studentClassID
Inner Join scoreTypes on scores.scoreTypeID = scoreTypes.ScoreTypeID
inner join classes on studentClasses.classID = classes.classID
inner join students on studentClasses.studentID = students.StudentID
inner join deptTypes on classes.departmentTypeID = deptTypes.departmentTypeID