DROP DATABASE if exists lab1;
create database lab1;
use lab1;

-- 创建图书表
CREATE TABLE Book (
  bid CHAR(8),
  bname VARCHAR(100) NOT NULL,
  author VARCHAR(50),
  price FLOAT,
  bstatus int default 0 check (bstatus in (0,1,2)),
  borrow_Times int default 0 check (borrow_Times>=0),
  reserve_Times int default 0 check (reserve_Times>=0),
  constraint PK_Book primary key(bid)
);

-- 创建读者表
CREATE TABLE Reader (
  rid CHAR(8),
  rname VARCHAR(20),
  age INT,
  address VARCHAR(100),
  constraint PK_Reader primary key(rid)
);

-- 创建借阅表
CREATE TABLE Borrow (
  book_ID CHAR(8),
  reader_ID CHAR(8),
  borrow_Date DATE,
  return_Date DATE,
  constraint PK_Borrow primary key(book_ID,reader_ID,borrow_Date),
  constraint FK_Borrow_Book foreign key(book_ID) references Book(bid),
  constraint FK_Borrow_Reader foreign key(reader_ID) references Reader(rid)
);

-- 创建预约表
CREATE TABLE Reserve (
    book_ID CHAR(8),
    reader_ID CHAR(8),
    reserve_Date DATE DEFAULT (CURDATE()),
    take_Date DATE,
    constraint PK_Borrow primary key(book_ID,reader_ID,reserve_Date),
    constraint FK_Reserve_Book foreign key(book_ID) references Book(bid),
    constraint FK_Reserve_Reader foreign key(reader_ID) references Reader(rid)
    -- constraint CHK_Reserve check (take_Date<reserve_Date)
);


-- 插入图书数据
INSERT INTO book (bid, bname, author, price, borrow_times, reserve_times, bstatus) 
VALUES 
('B001', 'The Hobbit', 'J.R.R. Tolkien', 18.99, 4, 1, 2),
('B002', 'Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 25.50, 3, 0, 1),
('B003', 'Harry Potter and the Philosopher\'s Stone', 'J.K. Rowling', 14.7, 2, 0, 1),
('B004', 'To Kill a Mockingbird', 'Harper Lee', 12.99, 0, 0, 0),
('B005', '1984', 'George Orwell', 10.50, 0, 1, 2),
('B006', 'Learning MySQL: Get a Handle on Your Data', 'Seyed M.M. (Saied) Tahaghoghi, Hugh E. Williams', 29.99, 1, 0, 1),
('B007', 'Pride and Prejudice', 'Jane Austen', 14.25, 1, 0, 1),
('B008', 'The Catcher in the Rye', 'J.D. Salinger', 11.20, 0, 2, 2),
('B009', 'Brave New World', 'Aldous Huxley', 13.80, 1, 0, 1),
('B010', 'Animal Farm', 'George Orwell', 8.99, 1, 1, 1) ,
('B011', 'MySQL Cookbook: Solutions for Database Developers and Administrators', 'Paul DuBois', 35.50, 1, 0, 0),
('B012', 'Test your trigger here', 'TA', 10.4, 0, 0, 0)
;


-- 插入读者数据
INSERT INTO reader (rid, rname, age, address)
VALUES
('R001', 'John', 35, '456 Oak St, Othertown'),
('R002', 'Rose', 35, '123 Main St, Anytown'),
('R003', 'Emma', 30, '123 Elm St, Anytown'),
('R004', 'Sophia', 28, '789 Maple St, Somewhere'),
('R005', 'Emily', 28, '456 Elm St, Othertown'),
('R006', 'Michael', 40, '789 Oak St, Somewhere');

-- 插入借阅数据
INSERT INTO borrow (book_id, reader_id, borrow_date, return_date)
VALUES
('B001', 'R002', '2024-03-01', '2024-03-15'),
('B003', 'R001', '2024-03-05', '2024-03-20'),
('B002', 'R001', '2024-03-10', NULL),
('B001', 'R004', '2024-03-15', '2024-03-16'),
('B006', 'R005', '2024-03-03', NULL),
('B003', 'R001', '2024-03-21', NULL),
('B001', 'R005', '2024-03-17', '2024-03-18'),
('B001', 'R006', '2024-03-19', '2024-03-20'),
('B002', 'R001', '2024-03-08', '2024-03-09'),
('B002', 'R005', '2024-03-09', '2024-03-10'),
('B011', 'R005', '2024-03-11', '2024-03-25'),
('B010', 'R002', '2024-03-12', NULL),
('B007', 'R005', '2024-03-03', NULL),
('B009', 'R005', '2024-03-03', NULL);

-- 插入预约数据
INSERT INTO reserve (book_id, reader_id, take_date)		-- ver1将预约数据中4月改为6月
VALUES
('B001', 'R001', '2024-06-08'),
('B005', 'R004', '2024-06-08'),
('B008', 'R005', '2024-06-10'),
('B008', 'R002', '2024-06-10'),
('B010', 'R006', '2024-06-15');