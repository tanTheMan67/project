CREATE DATABASE library;
USE library;
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    category VARCHAR(50)
);
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    enrolled_date DATE
);
CREATE TABLE IssuedBooks (
    issue_id INT PRIMARY KEY,
    student_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
INSERT INTO Books VALUES (1,'Open','Andre Agassi','Sports');
INSERT INTO Books VALUES (2,'Shoe Dog','Phil Knight','Sports');
INSERT INTO Books VALUES (3,'The Test','Brendon McCullum','Sports');
INSERT INTO Books VALUES (4,'Story','Robert McKee','Movies');
INSERT INTO Books VALUES (5,'Adventures in the Screen Trade','William Goldman','Movies');
INSERT INTO Books VALUES (6,'The Shawshank Redemption Screenplay','Frank Darabont','Movies');
INSERT INTO Books VALUES (7,'Clean Code','Robert Martin','Technology');
INSERT INTO Books VALUES (8,'The Pragmatic Programmer','Andrew Hunt','Technology');
INSERT INTO Books VALUES (9,'You Don''t Know JS','Kyle Simpson','Technology');

INSERT INTO Students VALUES (1,'Alice','alice@college.edu','2023-01-10');
INSERT INTO Students VALUES (2,'Bob','bob@college.edu','2021-03-15');
INSERT INTO Students VALUES (3,'Carol','carol@college.edu','2022-07-20');
INSERT INTO Students VALUES (4,'David','david@college.edu','2019-05-01');
INSERT INTO Students VALUES (5,'Eva','eva@college.edu','2020-08-11');
INSERT INTO IssuedBooks VALUES (1,1,1,'2025-03-10',NULL);
INSERT INTO IssuedBooks VALUES (2,2,4,'2025-02-20',NULL);
INSERT INTO IssuedBooks VALUES (3,3,7,'2025-03-28','2025-04-01');
INSERT INTO IssuedBooks VALUES (4,4,9,'2021-01-10','2021-01-20');
INSERT INTO IssuedBooks VALUES (5,5,2,'2025-03-01',NULL);
INSERT INTO IssuedBooks VALUES (6,1,8,'2025-03-18',NULL);
INSERT INTO IssuedBooks VALUES (7,2,5,'2025-01-05',NULL);
INSERT INTO IssuedBooks VALUES (8,3,3,'2024-11-10','2024-11-25');
SELECT s.name, b.title, b.category, ib.issue_date,
       DATEDIFF(CURDATE(), ib.issue_date) AS days_overdue
FROM IssuedBooks ib
JOIN Students s ON ib.student_id = s.student_id
JOIN Books b ON ib.book_id = b.book_id
WHERE ib.return_date IS NULL
  AND DATEDIFF(CURDATE(), ib.issue_date)>14
ORDER BY days_overdue DESC;

SELECT b.category,COUNT(*) AS total_borrowed
FROM IssuedBooks ib
JOIN Books b ON ib.book_id = b.book_id
GROUP BY b.category
ORDER BY total_borrowed DESC;


SELECT b.title,b.author,b.category
FROM Books b
LEFT JOIN IssuedBooks ib ON b.book_id = ib.book_id
WHERE ib.issue_id IS NULL;


DELETE FROM Students
WHERE student_id NOT IN(
    SELECT DISTINCT student_id FROM IssuedBooks
    WHERE issue_date>=DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
);
