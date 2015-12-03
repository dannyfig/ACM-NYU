/*** We delete or 'DROP' the tables before creating them -- it's just to be safe ***/
DROP TABLE IF EXISTS College;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Apply;

/**************************************************************
  We're at step 1: how do we even create tables? Well, there's
  a general recipe that we'll be following:
**************************************************************/

CREATE TABLE <table_name> (
  <column_1> <data_type> <additional_constraints>,
  <column_2> <data_type> <additional_constraints>,
  <column_3> <data_type> <additional_constraints>,
  /*** keep adding columns until you're happy ***/
  <last_column> <data_type> <additional_constraints>
);

/**************************************************************
  We generally want to separate tables by what's relevant
  to each "party involved" or "segment". You'll (hopefully)
  see what I mean soon:
**************************************************************/

/**************************************************************
  Will hold information pertaining to each college.
  This is what our College table will look like:

  +-------+-------+------------+
  | cName | state | enrollment |
  +-------+-------+------------+
**************************************************************/
CREATE TABLE College (
  cName text NOT NULL UNIQUE,
  state text NOT NULL,
  enrollment int NOT NULL
);

/**************************************************************
  Will hold information pertaining to each student
  This is what our Student table will look like:

 +-----+-------+-----+--------+
 | sID | sName | GPA | sizeHS |
 +-----+-------+-----+--------+
**************************************************************/
CREATE TABLE Student (
  sID int NOT NULL UNIQUE,
  # sID int PRIMARY KEY,
  sName text,
  GPA real,
  sizeHS int
);

/**************************************************************
  Will hold information pertaining to each application
  This is what our Application table will look like:

 +-----+-------+-------+----------+
 | sID | sName | major | decision |
 +-----+-------+-------+----------+
**************************************************************/

CREATE TABLE Application (
  sID int,
  cName text,
  major text,
  decision text
  # , FOREIGN KEY (sID) REFERENCES Student(sID)

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
