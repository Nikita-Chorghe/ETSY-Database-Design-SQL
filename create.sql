-- Queries to Create Databases based on normalised the ER diagram
CREATE TABLE users (
    user_Id VARCHAR(10) PRIMARY KEY,
    email VARCHAR(25),
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25),
    phone_number NUMBER(10),
    user_address VARCHAR(50),
    User_password VARCHAR(30) NOT NULL
);

CREATE TABLE messages(
    message_id VARCHAR(10) PRIMARY KEY,
    message_body VARCHAR(255),
    subject VARCHAR(100),
    user_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE buyer(
    buyer_id VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (buyer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE seller(
    seller_id VARCHAR(10) PRIMARY KEY,
    business_location VARCHAR(255),
    contact NUMBER(10),
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE

);

CREATE TABLE announcement(
    announcement VARCHAR (255) NOT NULL,
    seller_id VARCHAR(10),
    FOREIGN KEY (seller_id) REFERENCES SELLER(seller_id) ON DELETE CASCADE

);

CREATE TABLE payment_details(
    card_no INTEGER ,
    expiry DATE NOT NULL,
    cvv NUMBER(3) NOT NULL,
    zipcode NUMBER(5) NOT NULL,
    card_name VARCHAR(255) NOT NULL,
    buyer_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES BUYER (buyer_id) ON DELETE CASCADE,
    PRIMARY KEY (card_no,buyer_id)
);

CREATE TABLE products(
    product_id VARCHAR(10) PRIMARY KEY,
    seller_id VARCHAR(10) NOT NULL,
    description VARCHAR(50),
    color VARCHAR(10),
    category VARCHAR(20),
    price NUMBER(10) NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES SELLER(seller_id) ON DELETE CASCADE
);

CREATE TABLE user_order(
    order_id VARCHAR(10) PRIMARY KEY,
    order_status VARCHAR(20) NOT NULL,
    delivery_date DATE,
    order_date DATE DEFAULT CURRENT_DATE,
    -- Quantity INTEGER NOT NULL CHECK (Quantity >= 0),
    Delivery_address VARCHAR(255) NOT NULL,
    buyer_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES BUYER (buyer_id) ON DELETE CASCADE
);

CREATE TABLE order_contain(
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    order_quantity number DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES user_order(order_id) ON DELETE CASCADE,
    PRIMARY KEY (order_id,product_id)
);

CREATE TABLE shipment(
    shipping_id INTEGER PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    shipping_date DATE NOT NULL,
    seller_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES seller (seller_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES user_order(order_id) ON DELETE CASCADE
);


CREATE TABLE feedback(
    feedback_id VARCHAR(10) PRIMARY KEY,
    buyer_id VARCHAR(10) NOT NULL,
    description VARCHAR(50),
    product_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES buyer (buyer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE shopping_cart(
    cart_id VARCHAR(10) PRIMARY KEY,
    buyer_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES BUYER(buyer_id) ON DELETE CASCADE 
);

CREATE TABLE cart_contains(
    cart_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity NUMBER(10) DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (cart_id) REFERENCES SHOPPING_CART(cart_id) ON DELETE CASCADE
);

CREATE TABLE product_seller(
    product_id VARCHAR(10) NOT NULL,
    seller_id VARCHAR(10) NOT NULL,
    availabe_quantity VARCHAR(255) DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id) ON DELETE CASCADE
);

CREATE TABLE product_rating(
    product_id VARCHAR(10) NOT NULL,
    seller_id VARCHAR(10) NOT NULL,
    reviews VARCHAR(255),
    rating VARCHAR(255) CHECK (RATING>= 0 AND RATING<=5), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id) ON DELETE CASCADE
);


INSERT INTO USERS VALUES('1','niki@gmail', 'Miki', 'Joseph',1234567890, 'Texas', 'abc123');
INSERT INTO USERS VALUES('2','abc@gmail', 'Ross', 'John',1234567892, 'Texas', 'abc1233');

INSERT INTO MESSAGES VALUES('1A', 'about Product', 'Product', '1');
INSERT INTO MESSAGES VALUES('1B', 'About Product', 'Product', '2');

INSERT INTO SELLER VALUES('1', 'dallas',9876543210);
INSERT INTO SELLER VALUES('2', 'Austin',9870543210);

INSERT INTO ANNOUNCEMENT VALUES('ANNOUNCEMENT', '1');
INSERT INTO ANNOUNCEMENT VALUES('ANNOUNCEMENT2', '2');

INSERT INTO BUYER VALUES('1');
INSERT INTO BUYER VALUES('2');

INSERT INTO payment_details VALUES(12345, date '2024-02-09',123, 12345, '123456789', '1');

INSERT INTO PRODUCTS VALUES('67', '1', 'PRODUCT DESCRIPTION', 'RED', '5', 23);
INSERT INTO PRODUCTS VALUES('68', '2', 'PRODUCT ', 'BLUE', '9', 230);

INSERT INTO user_order VALUES('ASD1', 'COMPLETED', DATE '2022-03-03', DATE '2022-03-05','Richardson','2');
INSERT INTO user_order VALUES('PQR2', 'COMPLETED', DATE '2022-03-02', DATE '2022-03-08','Richardson','1');

INSERT INTO SHIPMENT VALUES(9,'ASD', DATE '2022-03-02','1');
INSERT INTO SHIPMENT VALUES(8,'PQR', DATE '2022-03-02','2');

INSERT INTO ORDER_CONTAIN VALUES('ASD','68');
INSERT INTO ORDER_CONTAIN VALUES('PQR','67');

INSERT INTO FEEDBACK VALUES('MNB','1', 'DESCRIPTION','67');
INSERT INTO FEEDBACK VALUES('MNV','2', 'DESCRIPTIONS','68');

INSERT INTO SHOPPING_CART VALUES('456','1');
INSERT INTO SHOPPING_CART VALUES('459','2');
INSERT INTO SHOPPING_CART VALUES('013','13');

INSERT INTO cart_contains VALUES('456','67',2);
INSERT INTO cart_contains VALUES('459','68',4);
INSERT INTO cart_contains VALUES('013','67',3);

INSERT INTO PRODUCT_SELLER VALUES('67','1',10);
INSERT INTO PRODUCT_SELLER VALUES('68','2',20);


SELECT * FROM USERS;
SELECT * FROM MESSAGES;
SELECT * FROM SELLER;
SELECT * FROM ANNOUNCEMENT;
SELECT * FROM BUYER;
SELECT * FROM payment_details;
SELECT * FROM PRODUCTS;
SELECT * FROM user_order;
SELECT * FROM SHIPMENT;
SELECT * FROM ORDER_CONTAIN;
SELECT * FROM FEEDBACK;
SELECT * FROM SHOPPING_CART;
SELECT * FROM cart_contains;
SELECT * FROM PRODUCT_SELLER;

-- SELECT * FROM 


CREATE
OR REPLACE PROCEDURE registerBuyer (
    user_Id IN VARCHAR,
    email IN VARCHAR,
    first_name IN VARCHAR,
    last_name IN VARCHAR,
    phone_number IN NUMBER,
    user_address in VARCHAR,
    pswd IN VARCHAR 
) AS BEGIN
INSERT INTO
    USERS
VALUES
    (
        user_Id,
        email,
        first_name,
        last_name,
        phone_number,
        user_address,
        pswd

    );
INSERT INTO
    BUYER
VALUES 
    (
        user_Id
    );

END registerBuyer;

CREATE
OR REPLACE PROCEDURE registerSeller(
    user_Id IN VARCHAR,
    email IN VARCHAR,
    first_name IN VARCHAR,
    last_name IN VARCHAR,
    phone_number IN NUMBER,
    user_address in VARCHAR,
    pswd IN VARCHAR,
    business_location IN VARCHAR,
    user_contact IN NUMBER
) AS BEGIN
INSERT INTO
    USERS
VALUES
    (
        user_Id,
        email,
        first_name,
        last_name,
        phone_number,
        user_address,
        pswd 
    );
INSERT INTO
    SELLER
VALUES 
    (
        user_Id,
        business_location,
        user_contact 
    );

END registerSeller;


BEGIN
 REGISTERSELLER( '12','niki1@gmail','Miki1','Joseph1',1334567890,'Tbexas','abc123','TEXAS',1234567894);
END;



BEGIN
 registerBuyer( '13','niki13@gmail','Miki3','Joseph3',1334567890,'TCexas','abc123');
END;

SELECT * FROM USERS;
SELECT * FROM SELLER;
SELECT * FROM BUYER;
SELECT * FROM USER_ORDER;




CREATE
OR REPLACE PROCEDURE place_order_from_cart (
    v_orderId IN VARCHAR,
    v_buyerId IN VARCHAR,
    v_deliveryDate IN DATE,
    v_delivery_address IN VARCHAR    
) AS

v_listPrice NUMBER := 0;
v_cartTotal NUMBER := 0;

CURSOR prodId IS
SELECT
    cart_contains.product_id, CART_CONTAINS.QUANTITY
FROM
    CART_CONTAINS
    INNER JOIN shopping_cart ON cart_contains.cart_id = shopping_cart.cart_id
WHERE
    buyer_id = v_buyerId;

v_pId VARCHAR(255);
v_cart_quantity number;

BEGIN 
    INSERT INTO
    USER_ORDER
VALUES
    (
        v_orderId,
        'Order Placed',
        v_deliveryDate,
        sysdate,
        v_delivery_address,
        v_buyerId
    );
    OPEN prodId;

LOOP 
    FETCH prodId INTO v_pId,v_cart_quantity;

EXIT
WHEN (prodId % notfound);

SELECT
    price INTO v_listPrice
FROM
    PRODUCTS
WHERE
    product_id = v_pId;

v_cartTotal := (v_cartTotal + (v_listPrice * v_cart_quantity));

INSERT INTO
    ORDER_CONTAIN
VALUES
    (v_orderId, v_pId,v_cart_quantity);

END LOOP;

CLOSE prodId;

dbms_output.put_line(v_cartTotal);


END place_order_from_cart;


BEGIN
    place_order_from_cart('123456', 13, date '2024-02-09', 'TEXAS');
END;

-- SELECT * FROM shopping_cart;
-- select * from products;
SELECT * from SHOPPING_CART;
select * from CART_CONTAINS;
select * from ORDER_CONTAIN;
select * from USER_ORDER;


-- DROP TABLE users;
-- DROP TABLE messages;
-- DROP TABLE BUYER;
-- DROP TABLE SELLER;
-- DROP TABLE ANNOUNCEMENT;





CREATE
OR REPLACE TRIGGER updateQuantity
AFTER
INSERT
    ON order_contain
    FOR EACH ROW 
DECLARE 
v_productId INTEGER;
v_quantity INTEGER;

CURSOR prodId IS
SELECT
    PRODUCT_ID, ORDER_QUANTITY
FROM
    ORDER_CONTAIN
WHERE
    order_id = :new.order_id;

BEGIN OPEN prodId;

LOOP FETCH prodId INTO v_productId,v_quantity;

EXIT
WHEN (prodId %notfound);

-- SELECT
--     available_quantity INTO v_quantity
-- FROM
--     product_seller
-- WHERE
--     product_id = v_productId;

UPDATE
    product_seller
SET
    AVAILABE_QUANTITY = AVAILABE_QUANTITY - v_quantity
WHERE
    product_id = v_productId;

END LOOP;

CLOSE prodId;

END updateQuantity;




CREATE
OR REPLACE TRIGGER emptyCart
AFTER
INSERT
    ON user_order 
    FOR EACH ROW 
    DECLARE 
    cartID varchar(255);
BEGIN
    select cart_id into cartID 
    from shopping_cart 
    where shopping_cart.BUYER_ID = :new.BUYER_ID;

DELETE FROM
    shopping_cart
WHERE
    shopping_cart.BUYER_ID = :new.BUYER_ID;

DELETE FROM
    CART_CONTAINS
WHERE
    cart_id = cartID;

END;