<!-- MongoDB Library for DIRAC -->
<!-- 
  Reads connection from environment variables:
  - MONGODB_URI (default: mongodb://localhost:27017)
  - MONGODB_DATABASE (can be overridden per operation)
-->
<dirac>

<!-- FIND: Query documents from a collection -->
<subroutine name="MONGO_FIND"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-limit="number:optional:limit results"
  param-sort="string:optional:JSON sort specification"
  meta-body="string:optional:JSON query filter"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    const queryObj = bodyText ? JSON.parse(bodyText) : {};
    const sortObj = sort ? JSON.parse(sort) : undefined;
    const limitNum = limit ? parseInt(limit, 10) : undefined;
    
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      let cursor = col.find(queryObj);
      if (sortObj) cursor = cursor.sort(sortObj);
      if (limitNum) cursor = cursor.limit(limitNum);
      
      const results = await cursor.toArray();
      return JSON.stringify(results, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- INSERT_ONE: Insert a single document -->
<subroutine name="MONGO_INSERT_ONE"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  meta-body="string:required:JSON document to insert"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    if (!bodyText) {
      throw new Error('Document body required for INSERT_ONE');
    }
    
    const doc = JSON.parse(bodyText);
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const insertResult = await col.insertOne(doc);
      return JSON.stringify({
        acknowledged: insertResult.acknowledged,
        insertedId: insertResult.insertedId.toString()
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- INSERT_MANY: Insert multiple documents -->
<subroutine name="MONGO_INSERT_MANY"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  meta-body="string:required:JSON array of documents"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    if (!bodyText) {
      throw new Error('Documents array required for INSERT_MANY');
    }
    
    const docs = JSON.parse(bodyText);
    if (!Array.isArray(docs)) {
      throw new Error('documents parameter must be a JSON array');
    }
    
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const insertResult = await col.insertMany(docs);
      return JSON.stringify({
        acknowledged: insertResult.acknowledged,
        insertedCount: insertResult.insertedCount,
        insertedIds: Object.values(insertResult.insertedIds).map(id => id.toString())
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- UPDATE_ONE: Update a single document -->
<subroutine name="MONGO_UPDATE_ONE"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-filter="string:required:JSON filter to match document"
  param-upsert="string:optional:create if not exists (true/false):false"
  meta-body="string:required:JSON update operations"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const filterObj = JSON.parse(filter);
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    if (!bodyText) {
      throw new Error('Update operations body required for UPDATE_ONE');
    }
    
    const updateObj = JSON.parse(bodyText);
    const upsertBool = upsert === 'true';
    
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const updateResult = await col.updateOne(filterObj, updateObj, { upsert: upsertBool });
      return JSON.stringify({
        acknowledged: updateResult.acknowledged,
        matchedCount: updateResult.matchedCount,
        modifiedCount: updateResult.modifiedCount,
        upsertedId: updateResult.upsertedId ? updateResult.upsertedId.toString() : null
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- UPDATE_MANY: Update multiple documents -->
<subroutine name="MONGO_UPDATE_MANY"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-filter="string:required:JSON filter to match documents"
  meta-body="string:required:JSON update operations"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const filterObj = JSON.parse(filter);
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    if (!bodyText) {
      throw new Error('Update operations body required for UPDATE_MANY');
    }
    
    const updateObj = JSON.parse(bodyText);
    
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const updateResult = await col.updateMany(filterObj, updateObj);
      return JSON.stringify({
        acknowledged: updateResult.acknowledged,
        matchedCount: updateResult.matchedCount,
        modifiedCount: updateResult.modifiedCount
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- DELETE_ONE: Delete a single document -->
<subroutine name="MONGO_DELETE_ONE"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-filter="string:required:JSON filter to match document"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const filterObj = JSON.parse(filter);
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const deleteResult = await col.deleteOne(filterObj);
      return JSON.stringify({
        acknowledged: deleteResult.acknowledged,
        deletedCount: deleteResult.deletedCount
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- DELETE_MANY: Delete multiple documents -->
<subroutine name="MONGO_DELETE_MANY"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-filter="string:required:JSON filter to match documents"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const filterObj = JSON.parse(filter);
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const deleteResult = await col.deleteMany(filterObj);
      return JSON.stringify({
        acknowledged: deleteResult.acknowledged,
        deletedCount: deleteResult.deletedCount
      }, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- COUNT: Count documents matching filter -->
<subroutine name="MONGO_COUNT"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  meta-body="string:optional:JSON filter">
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    const filterObj = bodyText ? JSON.parse(bodyText) : {};
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      const count = await col.countDocuments(filterObj);
      return count.toString();
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

<!-- AGGREGATE: Run aggregation pipeline -->
<subroutine name="MONGO_AGGREGATE"
  param-database="string:optional:database name"
  param-collection="string:required:collection name"
  param-limit="number:optional:limit results"
  meta-body="string:required:JSON array of aggregation stages"
>
  <require_module name="mongodb" var="mongo" />
  
  <eval name="result">
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
    const dbName = database || process.env.MONGODB_DATABASE;
    
    if (!dbName) {
      throw new Error('Database name required: set param-database or MONGODB_DATABASE env var');
    }
    
    const params = getParams();
    const bodyText = params && params.text ? params.text.trim() : '';
    if (!bodyText) {
      throw new Error('Pipeline array required for AGGREGATE');
    }
    
    const pipelineArr = JSON.parse(bodyText);
    if (!Array.isArray(pipelineArr)) {
      throw new Error('pipeline parameter must be a JSON array');
    }
    
    const limitNum = limit ? parseInt(limit, 10) : undefined;
    const client = new mongo.MongoClient(uri);
    
    try {
      await client.connect();
      const db = client.db(dbName);
      const col = db.collection(collection);
      
      let cursor = col.aggregate(pipelineArr);
      if (limitNum) cursor = cursor.limit(limitNum);
      
      const results = await cursor.toArray();
      return JSON.stringify(results, null, 2);
    } finally {
      await client.close();
    }
  </eval>
  
  <output><variable name="result"/></output>
</subroutine>

</dirac>
