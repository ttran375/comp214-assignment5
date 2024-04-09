# Advanced Database Concepts Project - COMP214

## Group Project Winter 2024 - E-Commerce Database Project

### Project Guidelines

A database exists as an important part of an information system. Your database will be an essential component of an e-commerce solution, facilitating the production of a system that supports business requirements, is user-friendly, and meets users’ needs.

The first step in the database design process is to determine the data requirements, which involves:

- Collecting and evaluating existing data.
- Researching missing or incomplete data.
- Talking to users to determine operation of the system, their needs, and the desired outputs.

#### To get started

- You will use your Oracle account to create and maintain the database.
- You will follow the traditional systems development life cycle for this project.

### Phase 1 - Data Requirements Phase

This phase is concerned primarily with fact finding and would involve interviews, surveys, research, etc.

### Phase 2 – Conceptual Data Modeling Phase

Schema: Descriptive information about the data stored, including organization of data items, relationships among tables, and details of physical data store organization.

### Phase 3 – Logical Database Design Phase

Transform the conceptual data model into a format understandable by a commercial DBMS, specifying the appropriate conceptual data model, inputs, processes, and output requirements.

### Phase 4 – Physical Database Design Phase

This phase yields the internal schema representing the storage view of the database and a populated, functional database.

### Project Deliverables

#### Conceptual modeling requirements:

- Create ERDs for all entities to show the relationships between them.

#### Database and tables requirements for project:

1. Create the e-commerce database on your oracle account. You can decide which group member’s account will be used for the project or work on files independently.
2. Database should include tables. You can follow a similar structure used in the creation of the Brewbeans database used in class.
3. You should have a minimum of 10 tables, maximum 15 for this project.
4. Each table must include a primary key and all necessary fields. You must set the field properties as required to collect the needed data.
5. You must do an ERD for your tables showing a descriptive column name, data type, size, and constraints where necessary.
6. Procedures - You need to define at least two procedures to carry out common operations on database.
7. Functions - You need to define at least one function to carry out common operations on database.
8. Sequences – you need to create at least one sequence and use it especially for those tables that are updated with values.
9. Indexes – Search is a common functionality performed on tables. You need to create a few indexes for those tables where search is performed heavily.
10. Triggers – For behind-the-scenes table entry/updating, you need to create at least 2 triggers.
11. Use the prefix gpnr_ for each of your table names.
12. If selling products for your project, all products must belong to a category and products can have attributes such as colour or size.
13. Products must include prices.
14. The shopping cart must indicate products, prices and quantities and a status, i.e., checked out or not.
15. Customers must have relevant contact information.
16. Shipping may be to the home address or any other address. There must be a shipping status default value.
17. Populate each table with at least 10 records, the data should be meaningful data.

### Rubric

- 5 points - ER model
- 5 points - Table creation
- 15 points – Creation/Use of Procedures, Functions, Indexes, Sequences, Triggers
