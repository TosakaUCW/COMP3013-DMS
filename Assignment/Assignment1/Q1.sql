-- a)	Find the name of books which are written by Kleene (author).
SELECT bname
FROM book
WHERE author = 'Kleene';
-- b)	Find the name of books which have received a rating score less than 3.
SELECT DISTINCT b.bname
FROM book b
    JOIN rating r ON b.bID = r.bID
WHERE r.score < 3;
-- c)	Find the name of reviewers who have made a comment to book “Quantum Finance” (book name).
SELECT DISTINCT r.rname
FROM reviewer r
    JOIN comment c ON r.rID = c.rID
    JOIN book b ON c.bID = b.bID
WHERE b.bname = 'Quantum Finance';
-- d)	Find the name of reviewers who have written some book.
SELECT DISTINCT r.rname
FROM reviewer r
    JOIN book b ON r.rname = b.author;
-- e)	Find the authors who have written multiple books.
SELECT author
FROM book
GROUP BY author
HAVING count(*) > 1;
-- f)	Find the name of books which have been rated at both score 1 and score 5.
SELECT DISTINCT b.bname
FROM book b
    JOIN rating r1 ON b.bID = r1.bID
    AND r1.score = 1
    JOIN rating r2 ON b.bID = r2.bID
    AND r2.score = 5;
-- g)	Can one reviewer rate a book multiple times? Why?
-- No, a reviewer cannot rate a book multiple times.
-- Because the keys of the rating table is (rID, bID).
-- This means that each reviewer (rID) can have only one rating entry per book (bID), enforcing a one-time rating per reviewer-book pair.