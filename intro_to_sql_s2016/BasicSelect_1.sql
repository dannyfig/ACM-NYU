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
  Things to know:

    Primary keys:
      The PRIMARY KEY constraint uniquely identifies each record in a database table.
      Primary keys must contain UNIQUE values.
      A primary key column cannot contain NULL values.
      Most tables should have a primary key, and each table can have only ONE primary key.

    Foreign keys:
      A FOREIGN KEY in one table points to a PRIMARY KEY in another table.
      We use foreign keys in order to *join* two tables, but we'll see this later.

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
  names from Application.
**************************************************************/

SELECT Student.sName, Application.cName
FROM Student, Application;

/**************************************************************
  We'll query for student names and majors for which they've applied
  Note: the sID in our Student table is our PRIMARY KEY and
        the sID in our Application table is our FOREIGN KEY, which
        refers the the Student table's PRIMARY KEY
**************************************************************/

SELECT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/*** Same query with distinct student names, major for each application ***/

SELECT DISTINCT sName, major
FROM Student, Application
WHERE Student.sID = Application.sID;

/**************************************************************
  Names AND GPAs of students with sizeHS < 1000 applying to
  CS at Stanford, and the application decision
**************************************************************/

SELECT sName, GPA, decision
FROM Student, Application
# matching each student to their application via sID
WHERE Student.sID = Application.sID
  AND sizeHS < 1000
  AND major = 'CS'
  AND cName = 'Stanford';

/**************************************************************
  Let's query for all large campuses (enrollment > 2000) with CS applicants
**************************************************************/

/*** Note: something's odd about this query. What is it? ***/

SELECT cName
FROM College, Application
WHERE College.cName = Application.cName
  AND enrollment > 20000
  AND major = 'CS';

/*** Fix our ambiguity error ***/

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
  String matching: A Crash Course

    In SQL, the LIKE operator is used to search for a specified
    pattern in a column. Our general syntax follows:
**************************************************************/

SELECT <column_with_text_data>
FROM <table>
WHERE <column_with_text_data> LIKE <pattern>;

/**************************************************************
  We can query for text as such:
**************************************************************/

/*** Return all majors that have "bio" in them ***/
SELECT sID, major
FROM Application
WHERE major LIKE '%bio%';

/*** Return majors that start with "bio", followed by zero or more chars ***/
SELECT sID, major
FROM Application
WHERE major LIKE 'bio%'

/*** Return majors that start with zero or more chars, followed by "bio" ***/
SELECT sID, major
FROM Application
WHERE major LIKE '%bio'

/*** Return majors that have any char followed by 'E' ***/
SELECT sID, major
FROM Application
WHERE major LIKE '_E';

/*** More underscores ***/
SELECT sID, major
FROM Application
WHERE major LIKE 'ps_chol_gy';

/**************************************************************
  SELECT * cross-product
**************************************************************/

/*** What does this output look like? ***/
SELECT *
FROM Student, College;

/**************************************************************
  Add scaled GPA based on sizeHS
  Also note missing WHERE clause
**************************************************************/

SELECT sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0)
FROM Student;

/**************************************************************
  Here we use an alias so that our resulting columns go from this:

  +-----+-------+-----+--------+---------------------+
  | sID | sName | GPA | sizeHS | GPA*(sizeHS/1000.0) |
  +-----+-------+-----+--------+---------------------+

  to this:

  +-----+-------+-----+--------+-----------+
  | sID | sName | GPA | sizeHS | scaledGPA |
  +-----+-------+-----+--------+-----------+

**************************************************************/

SELECT sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) AS scaledGPA
FROM Student;
