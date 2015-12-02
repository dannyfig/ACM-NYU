/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
  To start out, our SELECT statement queries will have a
  general form to them:
**************************************************************/

SELECT <column>
FROM <table>
WHERE <conditional>;

/**************************************************************
  Basics: the asterisk (*) character selects ALL columns from our table
**************************************************************/

SELECT *
FROM Student;

/*** Same query, except we only want GPA > 3.0 students ***/

SELECT *
FROM Student
WHERE GPA > 3.0;

/**************************************************************
  IDs, names, and GPAs of students with GPA > 3.6
**************************************************************/

SELECT sID, sName, GPA
FROM Student
WHERE GPA > 3.6;

/*** Same query, without GPA ***/

SELECT sID, sName
FROM Student
WHERE GPA > 3.6;

/**************************************************************
  We utilize the DISTINCT keyword to return distinct results
**************************************************************/

SELECT DISTINCT <column>
FROM <table>
WHERE <conditional>;

/*** Let's get a list of the colleges students are applying to ***/

SELECT cName
FROM Application;

/*** Too many repetitions! Let's get a unique list of names ***/

SELECT DISTINCT cName
FROM Application;

/**************************************************************
  TODO: mention primary, foreign keys

  Let's step it up and query two tables at once! How, you ask?
**************************************************************/

SELECT <column_in_table_1>, <column_in_table_2>
FROM <table_1>, <table_2>;

/*** How does this look? ***/

SELECT sID
FROM Student, Application;

/**************************************************************
Note: if a column is found in two tables (i.e. sID),
we have to be careful and prepend our column with its table.
Let's select all sID's from the Student and Application tables
**************************************************************/

SELECT Student.sID, Application.sID
FROM Student, Application;

/**************************************************************
  In practice: let's say we're having fun and wanted
  to select all student names from Student and college
  names from Application. Our query looks like:
**************************************************************/

SELECT Student.sName, Application.cName
FROM Student, Application;

/**************************************************************
  We'll query for student names and majors for which they've applied
**************************************************************/

SELECT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/*** Same query with distinct ***/

SELECT DISTINCT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/**************************************************************
  Names AND GPAs of students with sizeHS < 1000 applying to
  CS at Stanford, and the application decision
**************************************************************/

SELECT sName, GPA, decision
FROM Student, Application
WHERE Student.sID = Application.sID
  AND sizeHS < 1000
  AND major = 'CS'
  AND cname = 'Stanford';

/**************************************************************
  Let's query for all large campuses with CS applicants
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
