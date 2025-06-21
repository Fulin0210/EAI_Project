Create database ATAG;

CREATE table Users (
    Username VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL
        CONSTRAINT CHK_UserRole CHECK (Role IN ('Sales', 'Operational'))
);

SELECT * FROM Users;

Create table ClientBooking (
	BookingID INT IDENTITY (1,1) PRIMARY KEY,
	ClientName VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Phone VARCHAR(20),
	
	EventName VARCHAR(100) NOT NULL,
	EventType VARCHAR(20) NOT NULL 
    CONSTRAINT CHK_EventType CHECK (EventType IN ('Physical','Virtual')),
    EventDate DATE NOT NULL,
    EventDescription VARCHAR(500) NULL,
    
    BookingDate DATETIME NOT NULL DEFAULT GETDATE()
);

ALTER TABLE ClientBooking
ADD BookingStatus VARCHAR(20) NOT NULL 
    CONSTRAINT DF_BookingStatus DEFAULT 'Pending';

ALTER TABLE ClientBooking
ADD CONSTRAINT CHK_BookingStatus 
CHECK (BookingStatus IN ('Pending', 'Confirmed', 'Cancelled'));

SELECT * FROM ClientBooking;

CREATE TABLE EventBooking (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    ClientName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    
    EventName VARCHAR(100) NOT NULL,
    EventType VARCHAR(20) NOT NULL
        CONSTRAINT CHK_EventBooking_Type CHECK (EventType IN ('Physical', 'Virtual')),
    EventDate DATE NOT NULL,
    EventDescription VARCHAR(500),

    NumOfPax INT,
    EventLocation VARCHAR(200),
    AssignedPIC VARCHAR(100),

    ConfirmedDate DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (BookingID) REFERENCES ClientBooking(BookingID)
);

SELECT * FROM EventBooking;

INSERT INTO Users (Username, Password, Role)
VALUES
  ('salesuser', 'password123', 'Sales'),
  ('opsuser', 'password456', 'Operations');

ALTER TABLE Users DROP CONSTRAINT CHK_UserRole;

ALTER TABLE Users ADD CONSTRAINT CHK_UserRole CHECK (Role IN ('Sales', 'Operations'));

UPDATE ClientBooking
SET BookingStatus = 'Pending'
WHERE BookingID = 14;

ALTER TABLE EventBooking
ADD CONSTRAINT FK_EventBooking_ClientBooking_BookingID
FOREIGN KEY (BookingID)
REFERENCES ClientBooking(BookingID)
ON DELETE CASCADE;

INSERT INTO ClientBooking (
    ClientName,
    Email,
    Phone,
    EventName,
    EventType,
    EventDate,
    EventDescription
)
VALUES (
    'Alice Tan',
    'alice.tan@example.com',
    '018-7654321',
    'Team Building Workshop',
    'Virtual',
    '2025-06-27',
    'Squid Game'
);


