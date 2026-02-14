# dirac-mongodb

MongoDB integration library for DIRAC - provides CRUD operations and aggregations.

## Features

- ✅ **Complete CRUD Operations**: FIND, INSERT (one/many), UPDATE (one/many), DELETE (one/many), COUNT
- ✅ **Aggregation Pipeline**: Full MongoDB aggregation support
- ✅ **Environment Variables**: Uses MONGODB_URI and MONGODB_DATABASE (no config files needed)
- ✅ **Clean API**: Each operation is a separate tag
- ✅ **Automatic Cleanup**: Connection management handled automatically

## Installation

```bash
npm install dirac-mongodb mongodb
```

## Configuration

Set environment variables:

```bash
export MONGODB_URI="mongodb://localhost:27017"
export MONGODB_DATABASE="mydb"
```

Or use a `.env` file:
```env
MONGODB_URI=mongodb://localhost:27017
MONGODB_DATABASE=mydb
```

## Usage

### FIND - Query documents

```xml
<dirac>
  <import src="dirac-mongodb"/>
  
  <!-- Find all users -->
  <MONGO_FIND collection="users" query='{"age": {"$gt": 18}}'  limit="10"/>
  
  <!-- With sort -->
  <MONGO_FIND 
    collection="users" 
    query='{"status": "active"}' 
    sort='{"name": 1}' 
    limit="5"/>
</dirac>
```

### INSERT_ONE - Insert single document

```xml
<dirac>
  <import src="dirac-mongodb"/>
  
  <MONGO_INSERT_ONE 
    collection="users" 
    document='{"name": "Alice", "age": 25, "email": "alice@example.com"}'/>
</dirac>
```

### INSERT_MANY - Insert multiple documents

```xml
<dirac>
  <import src="dirac-mongodb"/>
  
  <MONGO_INSERT_MANY 
    collection="users" 
    documents='[
      {"name": "Bob", "age": 30},
      {"name": "Carol", "age": 28}
    ]'/>
</dirac>
```

## Environment Variables

- **MONGODB_URI**: MongoDB connection string (default: `mongodb://localhost:27017`)
- **MONGODB_DATABASE**: Default database name (can be overridden per operation)

## License

MIT
