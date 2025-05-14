## cluster 

In MongoDB, a cluster is a group of interconnected MongoDB servers that work together to provide high availability, scalability, and fault tolerance for your database system. MongoDB clusters are commonly used in production environments to ensure that your application can handle increased loads, maintain data integrity, and minimize downtime.

## collections and documents

as spoken about earlier 
collection is a collection of documents
a document is the actual database where the data is stored
a document has all entries as key value pairs

![[Pasted image 20230917095421.png]]

including all the keys, there is a particular key value pair called id 
that mongodb uses by defalut to uniquely identify each document uniquely

## using compass

to get started, we need to get connected using a connection string
![[Pasted image 20230917100409.png]]

A connection string in MongoDB is a specially formatted string that contains information needed to establish a connection between an application or client and a MongoDB database. It includes details like the server's address, port number, authentication credentials, and other optional parameters.

A typical MongoDB connection string has the following components:

1. **Protocol**: This specifies the protocol used for communication. For MongoDB, it is typically `mongodb://`.

2. **Server Address(es)**: This indicates the address or addresses of the MongoDB server(s) that the application will connect to. It can be an IP address or a domain name.

3. **Port Number**: This is the port number on which MongoDB is listening for connections. The default MongoDB port is 27017.

4. **Database Name**: Optionally, you can specify the default database that the application will connect to. If not provided, the connection will be made to the "test" database by default.

5. **Username and Password**: If authentication is required to access the database, the connection string will include the username and password.

6. **Authentication Database**: This is the database where the authentication credentials are stored. It is specified separately from the database you want to operate on.

7. **Connection Options**: Additional options can be included to customize the behavior of the connection, such as setting timeouts, enabling SSL, or specifying replica set options for high availability configurations.

8. **Query Parameters**: These parameters can be used to pass additional information to the server.

Here's an example of a MongoDB connection string:

```
mongodb://username:password@hostname:port/database?options
```

- `username` and `password` are the authentication credentials.
- `hostname` is the address of the MongoDB server.
- `port` is the port number (default is 27017).
- `database` is the default database to connect to.
- `options` are additional connection options.

It's worth noting that the exact format of the connection string may vary slightly depending on the MongoDB driver or framework being used in the application. Different drivers may have specific conventions or support additional parameters.

connect to locally installed database

- mongodb://localhost:27017

connect over mongodb atlas 
- obtain the connection string from mongodb atlas site(discussed later)
- Your connection string should look similar to this:

`mongosh "mongodb+srv://cluster0.ex4ht.mongodb.net/myFirstDatabase" --apiVersion 1 --username YOUR_USER_NAME

## mongoDb service 

mongodb service should start running automatically once a connection is established with a database, but it may not happen. to ensure it happens

- win key > services > scroll down till you find mongodb
- ![[Pasted image 20230917101248.png]]
- if it isn't running, manually "start" the process

if it is running and you want to terminate it, manually "stop" the process


there are 3 premade databases
- admin
- config
- local

we will not mess around with these databases but create our own 
- click on "+ create database" button
- enter database name and name of any 1 collection
- skip the check boxes

Now that we have a new database, we will add data to it 
![[Pasted image 20230917101951.png]]

for which
- click "+ add data"
- pick the "insert document" option
- ![[Pasted image 20230917102605.png]]
- click insert to get a new document

to insert multiple documents at once - use an array
```json
[
{
  "name": "Shubhman Gill",
  "age": 24,
  "runs_and_avg": [
    2000,
    61
  ],
  "icc_rank": 2
},
{
  "name": "Rohit Sharma",
  "age": 36,
  "runs_and_avg": [
    10000,
    48
  ],
  "icc_rank": 10
},
{
  "name": "Jasprit Bumrah",
  "age": 30,
  "wickets_and_avg": [
    200,
    20
  ],
  "icc_rank": 7
}
]
```

- notice that how even if you dont specify and id, mogodb can automatically generate it

### updating and deleting

in the compass gui, it is very simple to update and delete fields. the option appears when you hover over a document. it appears in the top right 

### filter out specific data
![[Pasted image 20230917103743.png]]
 in the filter bar given above, enter the particular entry to be found in json format and click find. the particular entry will be returned


# using mongosh

we use specific commands for specific purposes
- enter the shell 
 > go to terminal and type in
 > `mongosh`


- View all existing databases
`show dbs`
![[Pasted image 20230917110123.png]]
- Create a new or switch to existing databases 
`use <database_name>
![[Pasted image 20230917110150.png]]

![[Pasted image 20230917110253.png]]
the new database mydb doesnt come to existance until i create a document and add some data into it

- Delete Database 
`db.dropDatabase()

![[Pasted image 20230917110650.png]]

- View current Database
`db

- exit from the terminal
`exit`

- the '.' operator is used just like how we use it in js objects. each time we use it we can select a particular instance to work with
	- `db`  selects the database
	- `db.<collection_name>` selects the particular collection

#### Collection Commands
- Show all existing Collections
`show collections

- Create a collection named 'collection'
`db.createCollection('collection')
![[Pasted image 20230917112245.png]]

- Drop a collection named 'collection'
`db.collection.drop()

- You can also create a collection during the `insert` process.
We are here assuming `object` is a valid JavaScript object containing post data:

`db.posts.insertOne(object)

````jsx
db.bowlers.insertOne({
  "name": "Jasprit Bumrah",  "age": 30,  "wickets_and_avg": [ 200, 20 ], "icc_rank": 7
}) 
````

![[Pasted image 20230917113151.png]]

To insert multiple documents at once, use the `insertMany()` method, and use the array discussed earlier

**Ordered Inserts and Unordered inserts**

**Ordered Inserts:**
In an ordered insert, MongoDB will go through each piece one by one. If it encounters an issue (like a mistake or a conflict), it stops right there and doesn't add any more.

this is the default setting 

![[Pasted image 20230917154055.png]]

**Unordered Inserts:**
- if MongoDB encounters an issue with one piece of information, it doesn't stop the whole process. It just puts that piece aside and continues with the rest.
 
for which you need to specifically mention about the order that you have opted for

![[Pasted image 20230917154237.png]]
notice the extra
``{ ordered: false }
in the end of insertMany
![[Pasted image 20230917154329.png]]


- Show all documents in a Collection 
`db.collection.find()

- Show all documents in a Collection (Prettified)
`db.collection.find().pretty()

- Search for all documents for a specific entry
`db.collection.find({lang:'Python'})
multiple queries can be added, separated by commas one after the other, in json format

- Find the first document matching the specific entry
`db.collection.findOne({name: 'Harry'})

- Limit the number of rows in output - show only 'n' results of a search
`db.comments.find().limit(2)

by default, at any time, 20 entries are displayed
use `it` keyword to iteratively display next 20 entries

## Cursor Methods

- To obtain number of entries that  match a given condition
	 db.products.find({key: 'value'}).count();
	  
- To limit the display of number of entries
	 db.products.find({key: 'value'}).limit(5);
	  
- To display everything else skipping the first n entries
	 db.products.find({key: 'value'}).skip(2); 
	 
- To sort the documents in ascending or  descending order while displaying 
	 db.products.find({key: 'value'}'.sort({ price: 1 }); 
	- 1  for ascending and -1  for descending order sorting


- ## Projection
find methods accept a second parameter called `projection`.
This parameter is an `object` that describes which fields to include in the results.
**Note:** This parameter is optional. If omitted, all fields will be included in the results.
example: only display the `title` and `date` fields in the results.

```jsx
db.collection.find({}, {_id:0, title: 1, date: 1})
```

1 indicates true - include
0 indicates false - exclude

![[Pasted image 20230917120938.png]]

## When to use Quotes and when not to?

#### Special Characters 
If a field name contains special characters or spaces, or starts with a numeric digit, using quotes is necessary. 
#### Reserved Words 
If a field name is a reserved keyword in MongoDB, use quotes to distinguish it from the reserved keyword. 

# Case Sensitivity in MongoDB
Collection names are case-sensitive.
Field names within documents are also case-sensitive. 

`db.Product.insertOne({ name: 'thapa', age: 30 });  
`db.product.insertOne({ name: 'thapa', age: 30 });
these both make additions to different 

## Importing JSON in MongoDB

To import a JSON file into mongoDB as a collection of a database, we use

`mongoimport <jsonfile.json> –d <database_name> –c <collection_name>

`mongoimport products.json -d shop -c products`

here, we specify which database we want to import it to and what shoulf its name be as a collection.

to import multiple collections stored as an array in a single file, we use

`mongoimport products.json -d shop -c products --jsonArray`

![[Pasted image 20230918111732.png]]

## comparison operators:

- `$eq`: Matches values that are equal to a specified value.
- `$ne`: Matches values that are not equal to a specified value.
- `$gt`: Matches values that are greater than a specified value.
- `$gte`: Matches values that are greater than or equal to a specified value.
- `$lt`: Matches values that are less than a specified value.
- `$lte`: Matches values that are less than or equal to a specified value.
- `$in`: Matches any of the values specified in an array.
- `$nin`: Matches none of the values specified in an array.

Let's illustrate these operators using an example. Suppose we have a MongoDB collection called `products` with documents like this:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 3, "name": "Product C", "price": 30 }
{ "_id": 4, "name": "Product D", "price": 80 }
{ "_id": 5, "name": "Product E", "price": 60 }
```

Now, let's run some queries:

1. `$eq`: Find products with a price equal to 50.

```javascript
db.products.find({ price: { $eq: 50 } })
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
```

2. `$ne`: Find products with a price not equal to 60.

```javascript
db.products.find({ price: { $ne: 60 } })
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 3, "name": "Product C", "price": 30 }
{ "_id": 4, "name": "Product D", "price": 80 }
```

3. `$gt`: Find products with a price greater than 60.

```javascript
db.products.find({ price: { $gt: 60 } })
```

This will return:

```json
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 4, "name": "Product D", "price": 80 }
```

4. `$gte`: Find products with a price greater than or equal to 60.

```javascript
db.products.find({ price: { $gte: 60 } })
```

This will return:

```json
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 4, "name": "Product D", "price": 80 }
{ "_id": 5, "name": "Product E", "price": 60 }
```

5. `$lt`: Find products with a price less than 70.

```javascript
db.products.find({ price: { $lt: 70 } })
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
{ "_id": 3, "name": "Product C", "price": 30 }
{ "_id": 5, "name": "Product E", "price": 60 }
```

6. `$lte`: Find products with a price less than or equal to 70.

```javascript
db.products.find({ price: { $lte: 70 } })
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 3, "name": "Product C", "price": 30 }
{ "_id": 5, "name": "Product E", "price": 60 }
```

7. `$in`: Find products with prices listed in the list [30, 50, 70].

```javascript
db.products.find({ price: { $in: [30, 50, 70] } })
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50 }
{ "_id": 2, "name": "Product B", "price": 70 }
{ "_id": 3, "name": "Product C", "price": 30 }
```

8. `$nin`: Find products with prices not listed in the list [30, 50, 70].

```javascript
db.products.find({ price: { $nin: [30, 50, 70] } })
```

This will return:

```json
{ "_id": 4, "name": "Product D", "price": 80 }
```

These are just some examples to demonstrate how comparison operators work in MongoDB. You can use these operators in various combinations to construct more complex queries based on your specific requirements.

The query you provided is:

```javascript
db.products.find({
  $or: [
    { price: { $lt: 40 } },
    { price: { $gt: 70 } }
  ]
})
```

This query uses the `$or` operator to combine two conditions:

1. `{ price: { $lt: 40 } }`: This condition matches documents where the `price` field is less than 40.
2. `{ price: { $gt: 70 } }`: This condition matches documents where the `price` field is greater than 70.

The `$or` operator states that either of these conditions must be met for a document to be included in the result set.

Given the provided data:

```json
{ "_id": 1, "name": "Product A", "price": 50, "category": "Electronics" }
{ "_id": 2, "name": "Product B", "price": 70, "category": "Clothing" }
{ "_id": 3, "name": "Product C", "price": 30, "category": "Electronics" }
{ "_id": 4, "name": "Product D", "price": 80, "category": "Electronics" }
{ "_id": 5, "name": "Product E", "price": 60, "category": "Books" }
```

Sure! In MongoDB, logical operators are used to combine multiple conditions in a query. Here are the commonly used logical operators:

- `$and`: Joins multiple conditions and returns documents that satisfy all the conditions.
- `$or`: Joins multiple conditions and returns documents that satisfy at least one of the conditions.
- `$not`: Returns documents that do not match a specified condition.
- `$nor`: Joins multiple conditions and returns documents that do not satisfy any of the conditions.

Let's illustrate these operators using an example with a collection named `products`:

```json
{ "_id": 1, "name": "Product A", "price": 50, "category": "Electronics" }
{ "_id": 2, "name": "Product B", "price": 70, "category": "Clothing" }
{ "_id": 3, "name": "Product C", "price": 30, "category": "Electronics" }
{ "_id": 4, "name": "Product D", "price": 80, "category": "Electronics" }
{ "_id": 5, "name": "Product E", "price": 60, "category": "Books" }
```

Now, let's run some queries:

1. `$and`: Find products with a price between 40 and 70, belonging to the "Electronics" category.

```javascript
db.products.find({
  $and: [
    { price: { $gte: 40 } },
    { price: { $lte: 70 } },
    { category: "Electronics" }
  ]
})
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50, "category": "Electronics" }
```

2. `$or`: Find products with a price less than 40 or greater than 70.

```javascript
db.products.find({
  $or: [
    { price: { $lt: 40 } },
    { price: { $gt: 70 } }
  ]
})
```

This will return:

```json
{ "_id": 3, "name": "Product C", "price": 30, "category": "Electronics" }
{ "_id": 4, "name": "Product D", "price": 80, "category": "Electronics" }
```

3. `$not`: Find products with a price not equal to 60.

```javascript
db.products.find({
  price: { $not: { $eq: 60 } }
})
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50, "category": "Electronics" }
{ "_id": 2, "name": "Product B", "price": 70, "category": "Clothing" }
{ "_id": 3, "name": "Product C", "price": 30, "category": "Electronics" }
{ "_id": 4, "name": "Product D", "price": 80, "category": "Electronics" }
```

4. `$nor`: Find products that are not in the "Books" category and have a price less than 70.

```javascript
db.products.find({
  $nor: [
    { category: "Books" },
    { price: { $gte: 70 } }
  ]
})
```

This will return:

```json
{ "_id": 1, "name": "Product A", "price": 50, "category": "Electronics" }
{ "_id": 3, "name": "Product C", "price": 30, "category": "Electronics" }
```

These examples demonstrate how logical operators can be used to construct complex queries in MongoDB by combining multiple conditions.

## `$expr` operator 

in MongoDB allows you to use aggregation expressions within a query. This can be particularly useful when you need to compare fields from the same document in a more complex manner, or perform operations that are not directly supported by the regular query language.

The syntax of the `$expr` operator is:

```javascript
{ $expr: { operator: [field, value] } }
```

Here, `operator` can be any valid aggregation expression operator (like `$eq`, `$gt`, `$lt`, etc.). The `field` is the name of the field in the document, and `value` is the value or expression you want to compare it against.

Let's go through an example to illustrate how this works. Consider the following collection named `products`:

```json
{ "_id": 1, "name": "Product A", "price": 50, "discountedPrice": 45 }
{ "_id": 2, "name": "Product B", "price": 70, "discountedPrice": 60 }
{ "_id": 3, "name": "Product C", "price": 30, "discountedPrice": 35 }
{ "_id": 4, "name": "Product D", "price": 80, "discountedPrice": 70 }
```

Now, let's say we want to find products where the discounted price is less than the original price. We can use the `$expr` operator along with the `$lt` operator to achieve this:

```javascript
db.products.find({
  $expr: { $lt: ["$discountedPrice", "$price"] }
})
```

In this example, we're using the `$expr` operator with the `$lt` operator. We're comparing the `discountedPrice` field with the `price` field within the same document.

The result will be:

```json
{ "_id": 1, "name": "Product A", "price": 50, "discountedPrice": 45 }
{ "_id": 3, "name": "Product C", "price": 30, "discountedPrice": 35 }
```

Product A and Product C meet the condition where the discounted price is less than the original price.

This is just one simple example, but you can use the `$expr` operator with various other aggregation expressions to perform more complex comparisons or calculations within a query.

In MongoDB, the `$add`, `$subtract`, `$multiply`, and `$divide` are arithmetic aggregation operators used for performing mathematical operations within an aggregation pipeline. These operators can be used to perform calculations on fields or constants.

# note : examples contain aggregates that is covered later

Here is a brief explanation of each operator along with an example:

1. **$add**:
   - Adds two or more numbers.
   - Syntax: `{$add: [expression1, expression2, ...]}`

   Example:
   ```javascript
   db.sales.aggregate([
     {
       $project: {
         totalAmount: { $add: ["$price", "$tax"] }
       }
     }
   ])
   ```

   In this example, the `totalAmount` is calculated by adding the `price` and `tax` fields.

2. **$subtract**:
   - Subtracts one number from another.
   - Syntax: `{$subtract: [expression1, expression2]}`

   Example:
   ```javascript
   db.sales.aggregate([
     {
       $project: {
         discount: { $subtract: ["$regularPrice", "$discountedPrice"] }
       }
     }
   ])
   ```

   This example calculates the discount by subtracting the `discountedPrice` from the `regularPrice`.

3. **$multiply**:
   - Multiplies two or more numbers.
   - Syntax: `{$multiply: [expression1, expression2, ...]}`

   Example:
   ```javascript
   db.inventory.aggregate([
     {
       $project: {
         totalValue: { $multiply: ["$price", "$quantity"] }
       }
     }
   ])
   ```

   Here, `totalValue` is calculated by multiplying the `price` and `quantity`.

4. **$divide**:
   - Divides one number by another.
   - Syntax: `{$divide: [expression1, expression2]}`

   Example:
   ```javascript
   db.inventory.aggregate([
     {
       $project: {
         unitPrice: { $divide: ["$totalValue", "$quantity"] }
       }
     }
   ])
   ```

   This example calculates the `unitPrice` by dividing the `totalValue` by the `quantity`.

5. **Other Arithmetic Operators**:
   - `$mod`: Calculates the remainder of the division of two numbers.
   - `$abs`: Returns the absolute value of a number.
   - `$ceil`: Rounds a number up to the nearest integer.
   - `$floor`: Rounds a number down to the nearest integer.
   - `$ln`: Calculates the natural logarithm of a number.
   - `$log10`: Calculates the base 10 logarithm of a number.
   - `$pow`: Raises a number to the specified exponent.

   Example:
   ```javascript
   db.data.aggregate([
     {
       $project: {
         squaredValue: { $pow: ["$value", 2] }
       }
     }
   ])
   ```

   This example calculates the squared value of the `value` field using the `$pow` operator.

These arithmetic operators are very useful when you need to perform mathematical operations on the data during aggregation in MongoDB. They allow for complex calculations and transformations to be carried out as part of the aggregation pipeline.

