-- Tạo cơ sở dữ liệu
CREATE DATABASE n4c;
GO

-- Sử dụng cơ sở dữ liệu
USE n4c;
GO

-- Tạo bảng Users
CREATE TABLE Users (
    User_id INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    xp INT DEFAULT 0,
    Level INT DEFAULT 1
);
GO

-- Tạo bảng Courses
CREATE TABLE Courses (
    Course_id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description TEXT,
    Created_at DATETIME DEFAULT GETDATE()
);
GO

-- Tạo bảng Quizzes
CREATE TABLE Quizzes (
    Quiz_id INT IDENTITY(1,1) PRIMARY KEY,
    Course_id INT,
    Title NVARCHAR(255) NOT NULL,
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Course_id) REFERENCES Courses(Course_id)
);
GO

-- Tạo bảng Questions
CREATE TABLE Questions (
    Question_id INT IDENTITY(1,1) PRIMARY KEY,
    Quiz_id INT,
    Question_text TEXT NOT NULL,
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Quiz_id) REFERENCES Quizzes(Quiz_id)
);
GO

-- Tạo bảng QuizOptions
CREATE TABLE QuizOptions (
    Option_id INT IDENTITY(1,1) PRIMARY KEY,
    Question_id INT,
    Option_text VARCHAR(255) NOT NULL,
    Is_correct BIT DEFAULT 0,
    FOREIGN KEY (Question_id) REFERENCES Questions(Question_id)
);
GO

-- Tạo bảng UserCourses
CREATE TABLE UserCourses (
    User_course_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT,
    Course_id INT,
    Progress INT DEFAULT 0,
    Completed BIT DEFAULT 0,
    FOREIGN KEY (User_id) REFERENCES Users(User_id),
    FOREIGN KEY (Course_id) REFERENCES Courses(Course_id)
);
GO

-- Tạo bảng UserQuizzes
CREATE TABLE UserQuizzes (
    User_quiz_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT,
    Quiz_id INT,
    User_answer VARCHAR(255),
    Is_correct BIT,
    Attempted_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (User_id) REFERENCES Users(User_id),
    FOREIGN KEY (Quiz_id) REFERENCES Quizzes(Quiz_id)
);
GO
INSERT INTO Users (Username, Email, Password, xp, Level)
VALUES 
('user1', 'user@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 100, 2)


