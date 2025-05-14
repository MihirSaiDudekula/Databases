# $unwind
The code `db.products.aggregate([{ $unwind: "$colors" }])` will deconstruct the `colors` array in each document and produce multiple documents, one for each element in the `colors` array.

For example, if we have a document like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": ["Black", "Silver", "White"]
}
```

After applying the `$unwind` stage, the output will be:

```json
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": "Black"
}
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": "Silver"
}
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": "White"
}
```

As you can see, the `colors` array has been deconstructed, and a new document is created for each color. Each document retains the original fields (`_id`, `name`, `company`), and the `colors` field now contains one color from the original array.

This allows for further processing or grouping based on individual colors.

In MongoDB, the `$addToSet` stage is used within the aggregation framework to add elements to an array field while ensuring that duplicate values are not added.

### Syntax:

```javascript
{ $addToSet: <expression> }
```

- `<expression>`: The value or expression that you want to add to the set (array). Duplicate values will be automatically excluded.

Here's an example that demonstrates the use of `$addToSet`:

Suppose we have a collection of products with documents like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": ["Black", "Silver", "White"]
}
{
  "_id": 2,
  "name": "Tablet",
  "company": "74c23350e32f4a51b19b9236",
  "colors": ["Blue", "Red", "Blue"]
}
```

We want to create an array of unique colors across all products. We can achieve this using the `$addToSet` operator.

```javascript
db.products.aggregate([
  {
    $project: {
      _id: 0, // Exclude the _id field from the output
      uniqueColors: { $addToSet: "$colors" }
    }
  }
]);
```

In this example, we're using the `$project` stage to reshape the documents. We exclude the `_id` field and create a new field called `uniqueColors` using the `$addToSet` operator.

The result will be:

```json
{ "uniqueColors": ["Black", "Silver", "White"] }
{ "uniqueColors": ["Blue", "Red"] }
```

As you can see, the `uniqueColors` field contains an array of unique colors across all products. The `$addToSet` operator ensures that duplicate values are excluded from the resulting array.
### Example:

Suppose we have a collection of products with documents like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": ["Black", "Silver", "White"]
}
{
  "_id": 2,
  "name": "Tablet",
  "company": "74c23350e32f4a51b19b9236",
  "colors": ["Blue", "Red", "Blue"]
}
```

Now, let's use the `$unwind` stage followed by a `$group` stage with `$addToSet` to create an array of unique colors for each company:

```javascript
db.products.aggregate([
  { $unwind: "$colors" }, // Deconstruct the 'colors' array
  {
    $group: {
      _id: { company: "$company" },
      products: { $addToSet: "$colors" } // Add colors to a set (prevents duplicates)
    }
  }
]);
```

In this example, we're using the `$unwind` stage to deconstruct the `colors` array, similar to the previous example. Then, within the `$group` stage, we're using `$addToSet` to create an array of unique colors for each company.

The result will be:

```json
{ "_id": { "company": "64c23350e32f4a51b19b9235" }, "products": ["Black", "Silver", "White"] }
{ "_id": { "company": "74c23350e32f4a51b19b9236" }, "products": ["Blue", "Red"] }
```

As you can see, the `addToSet` operation ensures that only unique colors are included in the resulting array. In the second document, "Blue" only appears once, even though it was present twice in the original array.

In MongoDB, the `$size` stage is used within the aggregation framework to calculate the length of an array field.

### Syntax:

```javascript
{ $size: <array> }
```

- `<array>`: The array field whose length you want to calculate.

### Example:

Suppose we have a collection of products with documents like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "company": "64c23350e32f4a51b19b9235",
  "colors": ["Black", "Silver", "White"]
}
{
  "_id": 2,
  "name": "Tablet",
  "company": "74c23350e32f4a51b19b9236",
  "colors": ["Blue", "Red"]
}
```

Now, let's use the `$project` stage with `$size` to calculate the number of colors for each product:

```javascript
db.products.aggregate([
  {
    $project: {
      name: 1,
      numberOfColors: { $size: "$colors" } // Calculate the size of the 'colors' array
    }
  }
]);
```

In this example, we're using the `$project` stage to include the `name` field and calculate the number of colors using `$size`.

The result will be:

```json
{ "_id": 1, "name": "Laptop", "numberOfColors": 3 }
{ "_id": 2, "name": "Tablet", "numberOfColors": 2 }
```

As you can see, the output includes the `name` field and a newly calculated field `numberOfColors`, which represents the length of the `colors` array for each product.

In the first document, there are 3 colors ("Black", "Silver", "White"), so `numberOfColors` is 3. In the second document, there are 2 colors ("Blue", "Red"), so `numberOfColors` is 2.

Certainly! The `$limit` and `$skip` stages are used in the MongoDB aggregation framework to control the number of documents that are passed along in the pipeline.

### `$limit`:

The `$limit` stage restricts the number of documents that pass through the pipeline.

### Syntax:

```javascript
{ $limit: <positive integer> }
```

- `<positive integer>`: The maximum number of documents to allow through the pipeline.

### `$skip`:

The `$skip` stage allows you to skip a specified number of documents in the pipeline.

### Syntax:

```javascript
{ $skip: <positive integer> }
```

- `<positive integer>`: The number of documents to skip.

### Example:

Let's say we have a collection of products and we want to retrieve a subset of them using `$limit` and `$skip`.

```json
[
  { "_id": 1, "name": "Product A" },
  { "_id": 2, "name": "Product B" },
  { "_id": 3, "name": "Product C" },
  { "_id": 4, "name": "Product D" },
  { "_id": 5, "name": "Product E" },
  { "_id": 6, "name": "Product F" },
  { "_id": 7, "name": "Product G" },
  { "_id": 8, "name": "Product H" },
  { "_id": 9, "name": "Product I" },
  { "_id": 10, "name": "Product J" }
]
```

Now, let's use `$skip` to skip the first 3 documents and `$limit` to retrieve the next 4 documents:

```javascript
db.products.aggregate([
  { $skip: 3 }, // Skip the first 3 documents
  { $limit: 4 } // Limit the output to 4 documents
]);
```

The result will be:

```json
{ "_id": 4, "name": "Product D" }
{ "_id": 5, "name": "Product E" }
{ "_id": 6, "name": "Product F" }
{ "_id": 7, "name": "Product G" }
```

As you can see, the `$skip` stage skipped the first 3 documents, and then the `$limit` stage restricted the output to the next 4 documents.

## filter - the tricky part - re learn in yt brfore notes
In MongoDB, the `$filter` stage is used within the aggregation framework to filter elements of an array based on specified conditions.

### Syntax:

```javascript
{
  $project: {
    <field>: {
      $filter: {
        input: '$<array>',
        as: '<variable>',
        cond: <expression>
      }
    }
  }
}
```

- `<field>`: The field where you want to store the filtered array.
- `<array>`: The array you want to filter.
- `<variable>`: A variable that represents each element in the array during filtering.
- `<expression>`: The condition that each element must satisfy to be included in the filtered array.

### Example:

Suppose we have a collection of products with documents like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "colors": ["Black", "Silver", "White"]
}
{
  "_id": 2,
  "name": "Tablet",
  "colors": ["Blue", "Red"]
}
```

Now, let's use the `$filter` stage within a `$project` stage to filter the colors array to include only colors starting with the letter "B":

```javascript
db.products.aggregate([
  {
    $project: {
      _id: 0, // Exclude the _id field from the output
      filteredColors: {
        $filter: {
          input: '$colors',
          as: 'color',
          cond: { $eq: [{ $substr: ['$$color', 0, 1] }, 'B'] } // Filter by colors starting with 'B'
        }
      }
    }
  }
]);
```

In this example, we're using the `$project` stage to reshape the documents. We exclude the `_id` field and create a new field called `filteredColors` using the `$filter` operator.

The `$filter` operator is used to filter the `colors` array. For each element (`$$color`) in the array, we check if the first character of the color is equal to 'B' using `$substr` and `$eq`.

The result will be:

```json
{ "filteredColors": [] }
{ "filteredColors": ["Black"] }
```

As you can see, the `filteredColors` field contains the colors that start with the letter 'B'. In the first document, there are no such colors, so the array is empty. In the second document, "Black" is the only color that meets the condition.

here finding `cond` maybe tricky! It uses 2 `$` signs - `$$<-->`

In MongoDB, the `$addFields` stage is used within the aggregation framework to add new fields to documents. It provides a cleaner way to add fields compared to the `$project` stage.

### Syntax:

```javascript
{ $addFields: { <field1>: <expression1>, ... } }
```

- `<field1>`, `<field2>`, ...: The names of the new fields you want to add.
- `<expression1>`, `<expression2>`, ...: The expressions or values used to calculate the values of the new fields.

### Example:

Suppose we have a collection of products with documents like this:

```json
{
  "_id": 1,
  "name": "Laptop",
  "price": 100
}
{
  "_id": 2,
  "name": "Tablet",
  "price": 80
}
```

Now, let's use the `$addFields` stage to add a new field called `discountedPrice` to each document:

```javascript
db.products.aggregate([
  {
    $addFields: {
      discountedPrice: { $subtract: ["$price", 5] } // Calculate discounted price
    }
  }
]);
```

In this example, we're using the `$addFields` stage to add a new field called `discountedPrice`. The value of `discountedPrice` is calculated by subtracting 5 from the `price` field.

The result will be:

```json
{ "_id": 1, "name": "Laptop", "price": 100, "discountedPrice": 95 }
{ "_id": 2, "name": "Tablet", "price": 80, "discountedPrice": 75 }
```

As you can see, the `discountedPrice` field has been added to each document, and its value is based on the calculation specified in the expression. This provides a cleaner and more straightforward way to add new fields to documents in the aggregation pipeline.

