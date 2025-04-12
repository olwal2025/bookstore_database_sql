# bookstore_database_sql
Group SQL assignment to design and build a bookstore database using MySQL.

## Assignment Group
- **Catherine Olwal** (Group Leader) - ahendaolwal@gmail.com
- **Antonet Chepkoech** - anton.chepkoech@gmail.com
- **Yewande Florence Morris** - morrislewa@hotmail.com

This assignment implements a complete database system for a bookstore, tracking inventory, customers, orders and shipping. Our team collaborated on designing the schema, implementing the SQL scripts and testing the system.

## Database Schema

The database contains 15 tables organized into these main categories:

- **Book Information**: `book`, `author`, `publisher`, `book_language`, `book_author`
- **Customer Data**: `customer`, `address`, `country`, `customer_address`
- **Order Processing**: `cust_order`, `order_line`, `shipping_method`, `order_status`, `order_history`

Bookstore Database.drawio.png

## Key Features

- Tracks African literature with author nationality information
- Manages customer addresses across multiple African countries
- Processes orders with different shipping methods
- Maintains complete order history
- Includes sample data for testing

## Setup Instructions

1. Run the `bookstore.sql` script in MySQL to:
   - Create all tables
   - Set up database users
   - Load sample data

2. Database users:
   - Username: `antonet_user` / Password: `AntonetPass#92!rTxB`
   - Username: `yewande_user` / Password: `YewandePass#87!qLmC`

## Example Queries

Queries we've included:

```sql
-- Find books with author and publisher information
SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author 
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- View customer orders with status
SELECT c.first_name, c.last_name, o.order_date, s.status_name
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_status s ON o.order_status_id = s.order_status_id;
```

