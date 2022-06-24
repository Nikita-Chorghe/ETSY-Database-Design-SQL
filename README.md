# ETSY Database System

## Introduction
With the rise in online platforms for shopping, there are several products that cannot be found even on mainstream platforms like amazon and ebay. With creative minds coming together, there was a need for a marketplace to sell the innovations created by thousands of these creative minds. Personalization, art, craft, gifting and collectibles are some of the popular demands by consumers. Having to find a specific look for a particular gift and trying to make it personalized is not only a hard task but also archaic at the same time. Scrolling through a webpage/app is way easier when compared to having to go to craft stores for supplies and wandering around in different aisles for the required material. 
With the increase in the online platforms and easy online payment methods adhered with secure methods, this task was made easier and more interesting by Etsy. 
Etsy is an online shopping platform that has products ranging from personalized gifts for weddings, birthdays, anniversaries or any other occasion for that matter, to home decor including vintage looks. Important categories on the platform include jewelry, clothes, shoes, home & living, wedding & party, toys, entertainment, collectibles, art, craft supplies, gifts and gift cards. There are various sellers with different products, some produced in-house, because they are personalized, and some produced in higher quantities. Customers just search the type of product they are looking for and select the product that matches their needs from thousands of options. From here on the process works like any other online-shopping platform. There is a checkout cart, after which the user pays for their purchase and enters the remaining shipping details including the address for delivery, post which delivery handlers like FedEx and UPS take over and get it delivered to your doorstep without you having to worry about anything.  There are two entities that make ends meet on the platform: Buyer and Seller.

## Enhanced Entity-Relation Diagram
<img src="https://github.com/Nikita-Chorghe/ETSY-Database-Design-SQL/blob/master/Images/er.png"></img>

# Normalization

The following dependency exists in the Schema.


USERS(User-Id,  First-name,  Last-name,  Address,  Password,  Phone number,  Email)
User-Id  First-name,  Last-name,  Address,  Password,  Phone number,  Email
USER table is already in 1NF,2NF and 3NF no need to normalize

MESSAGES(Message-id,  User-id, Subject, Message body)
Message-id →  User-id, Subject, Message body
MESSAGES table is already in 1NF,2NF and 3NF no need to normalize

SELLER(Seller-id, Business_Location, Contact, Announcement )
Seller_id →  business_location, contact
Announcement( seller_id, announcement)
Seller_id → announcement
SELLER table has achieved 1NF,2NF and 3NF 

FEEDBACK(Feedback-id, Ratings, Description, Product-id, User-id)
Feedback-id →  Ratings, Description, Product-id, User-id
FEEDBACK table is already in 1NF,2NF and 3NF no need to normalize

SHOPPING CART(Cart-id, buyer_id)
Cart -id → buyer_id
SHOPPING CART table is already in 1NF,2NF and 3NF no need to normalize

PAYMENT DETAILS(Card-no, CVV, Expiry, Name, Zipcode, buyer-id)
Card-no →  CVV, Expiry Name, Zipcode, buyer-id
PAYMENT DETAILS table is already in 1NF,2NF and 3NF no need to normalize

SHIPMENT(Shipping-id, Order-id, Shipping Date, seller-id)
Shipping-id → Order-id Shipping Date seller-id)
SHIPMENT table is already in 1NF,2NF and 3NF no need to normalize

ORDERS(Order-id, Order status, order-quantity, Estimated delivery date, order-amount, order date, Delivery address, buyer-id)
Order-id → Order status, order-quantity, Estimated delivery date, order-amount, order date, Delivery address, buyer-id
ORDERS table is already in 1NF,2NF and 3NF no need to normalize

ORDER_LIST(Order-id, Product-id, Quantity)
Order-id → Product-id, Quantity
ORDER_LIST table is already in 1NF,2NF and 3NF no need to normalize

PRODUCT(Product-id, Quantity,  Product Images, Ratings, Product reviews, Colour, Description, Cost, Category)
Product-id →  Quantity, Product Images, Ratings, Product reviews, Colour, Description, Cost, Category   
PRODUCT table is not in 1NF 
Reviews and Rating can have multiple values
To make it in 1NF create another table of ratings and reviews.
product_rating(product_id, seller_id, rating, reviews)

Now product table will be PRODUCT(Product-id, Quantity,  Product Images,  Colour, Description, Cost, Category)

CART_LIST(Cart-id, Product-id, Quantity)
Cart-id → Product-id, Quantity
CART_LIST table is already in 1NF,2NF and 3NF no need to normalize

<img src="https://github.com/Nikita-Chorghe/ETSY-Database-Design-SQL/blob/master/Images/Normaliztion.png"></img>


## Conclusion

Etsy is an american e-commerce marketplace, mainly centered towards homemade, vintage, and craft supplies. It serves as a convenience for several occasions and needs around the country. With that high of a responsibility, there is a need for special attention by every seller for every product because of the presence of customizations. 
In this particular Database project, our team reverse engineered the database system of Etsy with special attention to detail for all of its functionalities to the most closely possible outcomes compared to the real database system. We understood and analyzed various aspects of the design involved in the creation of the e-commerce marketplace that we today know as Etsy. Furthermore, we enhanced our understanding of the creation of the database system in real time, including its normalization, leading to  having a lucid and conceptual image about real time databases and the design that comes with it. To conclude, the project was a great learning experience for the entire team because it helped us in having a greater comprehension of databases, their designs, and other concepts involved while working with a detailed database, inadvertently allowing us to  understand the precautionary measure needed while working on designing a database. 

