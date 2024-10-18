
/* CREATE TABLE IF NOT EXISTS book (
    book_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT,
    publication_year INTEGER,
    isbn TEXT UNIQUE
); */

-- Skapa Borrower-tabellen om den inte redan existerar
/* CREATE TABLE IF NOT EXISTS borrower (
    borrower_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT UNIQUE
); */

-- Skapa Loan-tabellen om den inte redan existerar
/* CREATE TABLE IF NOT EXISTS loan (
    loan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER,
    borrower_id INTEGER,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (borrower_id) REFERENCES borrower(borrower_id)
); */
/* 
INSERT INTO book (title, author, publication_year, isbn) 
VALUES 
('The Catcher in the Rye', 'J.D. Salinger', 1951, '9780316769488'),
('To Kill a Mockingbird', 'Harper Lee', 1960, '9780060935467'),
('1984', 'George Orwell', 1949, '9780451524935'),
('Pride and Prejudice', 'Jane Austen', 1813, '9781503290563'),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, '9780743273565');

INSERT INTO borrower (name, phone, email) 
VALUES 
('Alice Smith', '555-123-4567', 'alice@example.com'),
('Bob Johnson', '555-987-6543', 'bob@example.com'),
('Charlie Brown', '555-456-7890', 'charlie@example.com'),
('Diana Prince', '555-111-2222', 'diana@example.com'),
('Eve Adams', '555-333-4444', 'eve@example.com');

INSERT INTO loan (book_id, borrower_id, loan_date, due_date, return_date) 
VALUES 
(1, 2, '2023-09-15', '2023-09-30', NULL), -- Alice Smith lånar "The Catcher in the Rye"
(3, 1, '2023-10-05', '2023-10-20', NULL), -- John Doe lånar "1984"
(2, 3, '2023-09-20', '2023-10-05', '2023-09-30'), -- Charlie Brown lånade "To Kill a Mockingbird"
(4, 4, '2023-10-01', '2023-10-15', NULL), -- Diana Prince lånar "Pride and Prejudice"
(5, 5, '2023-09-25', '2023-10-10', '2023-10-05'); -- Eve Adams lånade "The Great Gatsby" */

-- presentera datan snyggare
/* .mode column
.headers on
SELECT * FROM book;

SELECT * FROM loan; */

--Join
/* .mode column
.headers on
SELECT Borrower.name, Book.title, Loan.loan_date
FROM Borrower
JOIN Loan ON Borrower.borrower_id = Loan.borrower_id
JOIN Book ON Loan.book_id = Book.book_id; */

--subquery
/* .mode column
.headers on
SELECT title FROM Book WHERE book_id IN (SELECT book_id FROM Loan WHERE borrower_id = 1); */


--GROUP BY och HAVING
/*
.mode column
.headers on 
SELECT Borrower.name, COUNT(Loan.loan_id) AS total_loans
FROM Borrower
JOIN Loan ON Borrower.borrower_id = Loan.borrower_id
GROUP BY Borrower.name
HAVING COUNT(Loan.loan_id) > 1; */



/* CREATE VIEW LoanDetails AS
SELECT 
    Loan.loan_id,
    Borrower.name AS borrower_name,
    Book.title AS book_title,
    Loan.loan_date,
    Loan.due_date,
    Loan.return_date
FROM 
    Loan
JOIN 
    Borrower ON Loan.borrower_id = Borrower.borrower_id
JOIN 
    Book ON Loan.book_id = Book.book_id; */

/* CREATE VIEW OverdueLoans AS
SELECT Loan.loan_id, Book.title, Borrower.name, Loan.due_date
FROM Loan
JOIN Book ON Loan.book_id = Book.book_id
JOIN Borrower ON Loan.borrower_id = Borrower.borrower_id
WHERE Loan.due_date < CURRENT_DATE AND Loan.return_date IS NULL; */

SELECT * FROM OverdueLoans;

--Säkerhetsaspekter att beakta:

1. Lösenordskrav: Tvinga användarna att använda starka lösenord med en blandning av stora/små bokstäver, siffror och specialtecken.
2. Hashning och saltning: Använd säkra hashfunktioner som bcrypt eller Argon2 och inkludera salt  för att göra lösenorden svårare att knäcka.
3. Rate Limiting: Begränsa antalet inloggningsförsök för att förhindra brute-force-attacker.
4. Tvåfaktorsautentisering (2FA): Implementera tvåfaktorsautentisering för ytterligare säkerhet.

Bibliotekssystemet består av tre huvudsakliga tabeller: Book, Borrower, och Loan. Tabellen Book lagrar information om varje bok, Borrower hanterar information om varje låntagare, och Loan håller reda på alla boklån och hur de relaterar till både böcker och låntagare.

Book: Innehåller information om varje bok i biblioteket, såsom titel, författare, publiceringsår och ISBN.
Borrower: Hanterar information om varje låntagare, såsom namn, telefonnummer och e-postadress.
Loan: Relaterar en bok till en låntagare och håller reda på när lånet utfärdades, dess förfallodatum, och om boken har återlämnats.

Rapport över databasstruktur, designval och implementering
Databasstruktur
Bibliotekssystemet består av tre huvudsakliga tabeller: Book, Borrower, och Loan. Tabellen Book lagrar information om varje bok, Borrower hanterar information om varje låntagare, och Loan håller reda på alla boklån och hur de relaterar till både böcker och låntagare.

Book: Innehåller information om varje bok i biblioteket, såsom titel, författare, publiceringsår och ISBN.
Borrower: Hanterar information om varje låntagare, såsom namn, telefonnummer och e-postadress.
Loan: Relaterar en bok till en låntagare och håller reda på när lånet utfärdades, dess förfallodatum, och om boken har återlämnats.