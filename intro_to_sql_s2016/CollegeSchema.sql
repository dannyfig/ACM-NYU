DROP TABLE IF EXISTS College;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Apply;

/*
  Q: Why are some things allowed to be NULL?

  The datatypes I've applied are flexible -- there's no reason why you can't
  use `varchar(n)` instead of `text`, it's merely a design choice.
*/

/* Will hold information pertaining to each college */
CREATE TABLE College (
  cName text NOT NULL UNIQUE,
  state text NOT NULL,
  enrollment int NOT NULL
);

/* Will hold information pertaining to each student */
CREATE TABLE Student (
  sID int NOT NULL UNIQUE,
  sName text,
  GPA real,
  sizeHS int
);

/* Will hold information pertaining to each application */
CREATE TABLE Application (
  sID int,
  cName text,
  major text,
  decision text
);

/*
  What is the relationship between each data table (if any)?
  One-to-one? One-to-many? Many-to-many?

  A: Each student can have multiple applications, so there's a
     one-to-many relationship between Student and Application.

     Denoted graphically as such:
     -------------             -----------------
     |  Student  |-------------|  Application  |
     ------------- 1         * -----------------

     Where the general format is:

     -------------             -------------
     |  Table_1  |-------------|  Table_2  |
     ------------- R_1     R_2 -------------

     And R_1 and R_2 are in the set/range {1, *}
*/
