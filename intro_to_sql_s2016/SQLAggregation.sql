/**************************************************************
  AGGREGATION
  Works for SQLite, MySQL
  Postgres doesn't allow ambiguous SELECT columns in Group-by queries
**************************************************************/

/**************************************************************
  Average GPA of all students
**************************************************************/

SELECT avg(GPA)
FROM Student;

/**************************************************************
  Lowest GPA of students applying to CS
**************************************************************/

SELECT min(GPA)
FROM Student, Apply
WHERE Student.sID = Apply.sID AND major = 'CS';

/**************************************************************
  Number of colleges bigger than 15,000
**************************************************************/

SELECT count(*)
FROM College
WHERE enrollment > 15000;

/**************************************************************
  Number of students applying to Cornell
**************************************************************/

/*** Let's count the number of applications to Cornell ***/

SELECT count(*)
FROM Apply
WHERE cName = 'Cornell';

/*** Account for one student's many applications to Cornell with DISTINCT ***/

SELECT Count(DISTINCT sID)
FROM Apply
WHERE cName = 'Cornell';

/**************************************************************
  TODO: GROUP BY:
**************************************************************/


/**************************************************************
Number of applications to each college
**************************************************************/

SELECT cName, count(*)
FROM Apply
GROUP BY cName;

/**************************************************************
  College enrollments by state
**************************************************************/

SELECT state, sum(enrollment)
FROM College
GROUP BY state;

/**************************************************************
  Minimum + maximum GPAs of applicants to each college & major
**************************************************************/

SELECT cName, major, min(GPA), max(GPA)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY cName, major;

/**************************************************************
  Number of colleges applied to by each student
**************************************************************/

SELECT Student.sID, count(distinct cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Add student name ***/

SELECT Student.sID, sName, count(distinct cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/**************************************************************
  Number of colleges applied to by each student, including
  0 for those who applied noWHERE
**************************************************************/

SELECT Student.sID, count(distinct cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/**************************************************************
  Colleges with fewer than 5 applications
**************************************************************/

/*** Note: this query is 'right', but we're wrong ***/
SELECT cName
FROM Apply
GROUP BY cName
HAVING count(*) < 5;

/*** Count the number of colleges with fewer than 5 applicants ***/

SELECT cName
FROM Apply
GROUP BY cName
HAVING count(distinct sID) < 5;
