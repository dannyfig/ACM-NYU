/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
  IDs, names, and GPAs of students with GPA > 3.6
**************************************************************/

SELECT sID, sName, GPA
FROM Student
WHERE GPA > 3.6;

/*** Same query without GPA ***/

SELECT sID, sName
FROM Student
WHERE GPA > 3.6;

/**************************************************************
  Student names and majors for which they've applied
**************************************************************/

SELECT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/*** Same query with distinct ***/

SELECT DISTINCT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/**************************************************************
  Names AND GPAs of students with sizeHS < 1000 Applicationing to
  CS at Stanford, and the application decision
**************************************************************/

SELECT sName, GPA, decision
FROM Student, Application
WHERE Student.sID = Application.sID
  AND sizeHS < 1000
  AND major = 'CS'
  AND cname = 'Stanford';

/**************************************************************
  All large campuses with CS applicants
**************************************************************/

SELECT cName
FROM College, Application
WHERE College.cName = Application.cName
  AND enrollment > 20000
  AND major = 'CS';

/*** Fix error ***/

SELECT College.cName
FROM College, Application
WHERE College.cName = Application.cName
  AND enrollment > 20000
  AND major = 'CS';

/*** Add distinct ***/

SELECT DISTINCT College.cName
FROM College, Application
WHERE College.cName = Application.cName
  AND enrollment > 20000
  AND major = 'CS';

/**************************************************************
  Application information
**************************************************************/

SELECT Student.sID, sName, GPA, Application.cName, enrollment
FROM Student, College, Application
WHERE Application.sID = Student.sID
  AND Application.cName = College.cName;

/*** Sort by decreasing GPA ***/

SELECT Student.sID, sName, GPA, Application.cName, enrollment
FROM Student, College, Application
WHERE Application.sID = Student.sID
  AND Application.cName = College.cName
ORDER BY GPA DESC;

/*** Then by increasing enrollment ***/

SELECT Student.sID, sName, GPA, Application.cName, enrollment
FROM Student, College, Application
WHERE Application.sID = Student.sID
  AND Application.cName = College.cName
ORDER BY GPA DESC, enrollment;

/**************************************************************
  Applicants to bio majors
**************************************************************/

SELECT sID, major
FROM Application
WHERE major LIKE '%bio%';

/*** Same query with SELECT * ***/

SELECT *
FROM Application
WHERE major LIKE '%bio%';

/**************************************************************
  SELECT * cross-product
**************************************************************/

SELECT *
FROM Student, College;

/**************************************************************
  Add scaled GPA based on sizeHS
  Also note missing WHERE clause
**************************************************************/

SELECT sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0)
FROM Student;

/*** Rename result attribute ***/

SELECT sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) AS scaledGPA
FROM Student;
