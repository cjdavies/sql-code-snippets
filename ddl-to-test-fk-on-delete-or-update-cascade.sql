/* DDL to test cascade delete and cascade update on FK constraints */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Orders
(
    OrderId INT         NOT NULL,
    Title   VARCHAR(50) NULL,
    CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED (OrderId ASC)
);

CREATE TABLE OrderItems
(
    OrderId     INT         NOT NULL,
    OrderItemId INT         NOT NULL,
    Title       VARCHAR(50) NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY CLUSTERED (OrderId ASC, OrderItemId ASC)
);

ALTER TABLE OrderItems WITH CHECK ADD CONSTRAINT FK01_OrderItems FOREIGN KEY(OrderId)
REFERENCES Orders (OrderId) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE OrderItems CHECK CONSTRAINT FK01_OrderItems;

INSERT INTO Orders
VALUES (1, 'Test Order 1');
INSERT INTO OrderItems
VALUES (1, 1, 'Test Order Item 1');
