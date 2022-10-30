CREATE TABLE Customers (
    [id] varchar(50),
    [first_name] varchar(50),
    [last_name] varchar(50),
    [street] varchar(50),
    [city] varchar(50),
    [state] varchar(50),
    [country] varchar(50),
    [phone] varchar(50),
    [email] varchar(50)
)

CREATE TABLE Pizzas (
    [pizza_id] varchar(50),
    [pizza_type_id] varchar(50),
    [size] varchar(50),
    [price] varchar(50)
)

CREATE TABLE Pizza_types (
    [pizza_type_id] varchar(50),
    [name] varchar(50),
    [category] varchar(50),
    [ingredients] varchar(MAX)
)

CREATE TABLE Orders (
    [order_id] varchar(50),
    [date] varchar(50),
    [customer_id] varchar(50),
    [time] varchar(50),
    [carrier_id] varchar(50)
)

CREATE TABLE Order_details (
    [order_details_id] varchar(50),
    [order_id] varchar(50),
    [pizza_id] varchar(50),
    [quantity] varchar(50)
)

CREATE TABLE Carrier (
    [carrier_id] varchar(50),
    [carrier_name] varchar(50),
    [address] varchar(50),
    [tax_id] varchar(50),
    [contact_person] varchar(50)
)