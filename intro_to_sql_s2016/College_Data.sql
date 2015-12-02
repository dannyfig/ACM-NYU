/**************************************************************
  Delete all values from Student, College, and Application
  (again, just to be safe)
**************************************************************/
DELETE FROM Student;
DELETE FROM College;
DELETE FROM Application;

/**************************************************************
  Insert a bunch of values into our data tables: Student, College, Application
**************************************************************/
INSERT INTO Student VALUES (123, 'Amy', 3.9, 1000);
INSERT INTO Student VALUES (234, 'Bob', 3.6, 1500);
INSERT INTO Student VALUES (345, 'Craig', 3.5, 500);
INSERT INTO Student VALUES (456, 'Doris', 3.9, 1000);
INSERT INTO Student VALUES (567, 'Edward', 2.9, 2000);
INSERT INTO Student VALUES (678, 'Fay', 3.8, 200);
INSERT INTO Student VALUES (789, 'Gary', 3.4, 800);
INSERT INTO Student VALUES (987, 'Helen', 3.7, 800);
INSERT INTO Student VALUES (876, 'Irene', 3.9, 400);
INSERT INTO Student VALUES (765, 'Jay', 2.9, 1500);
INSERT INTO Student VALUES (654, 'Amy', 3.9, 1000);
INSERT INTO Student VALUES (543, 'Craig', 3.4, 2000);

INSERT INTO College VALUES ('Stanford', 'CA', 15000);
INSERT INTO College VALUES ('Berkeley', 'CA', 36000);
INSERT INTO College VALUES ('MIT', 'MA', 10000);
INSERT INTO College VALUES ('Cornell', 'NY', 21000);

INSERT INTO Application VALUES (123, 'Stanford', 'CS', 'Y');
INSERT INTO Application VALUES (123, 'Stanford', 'EE', 'N');
INSERT INTO Application VALUES (123, 'Berkeley', 'CS', 'Y');
INSERT INTO Application VALUES (123, 'Cornell', 'EE', 'Y');
INSERT INTO Application VALUES (234, 'Berkeley', 'biology', 'N');
INSERT INTO Application VALUES (345, 'MIT', 'bioengineering', 'Y');
INSERT INTO Application VALUES (345, 'Cornell', 'bioengineering', 'N');
INSERT INTO Application VALUES (345, 'Cornell', 'CS', 'Y');
INSERT INTO Application VALUES (345, 'Cornell', 'EE', 'N');
INSERT INTO Application VALUES (678, 'Stanford', 'history', 'Y');
INSERT INTO Application VALUES (987, 'Stanford', 'CS', 'Y');
INSERT INTO Application VALUES (987, 'Berkeley', 'CS', 'Y');
INSERT INTO Application VALUES (876, 'Stanford', 'CS', 'N');
INSERT INTO Application VALUES (876, 'MIT', 'biology', 'Y');
INSERT INTO Application VALUES (876, 'MIT', 'marine biology', 'N');
INSERT INTO Application VALUES (765, 'Stanford', 'history', 'Y');
INSERT INTO Application VALUES (765, 'Cornell', 'history', 'N');
INSERT INTO Application VALUES (765, 'Cornell', 'psychology', 'Y');
INSERT INTO Application VALUES (543, 'MIT', 'CS', 'N');
