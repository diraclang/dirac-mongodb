<!-- Example: Basic MongoDB CRUD Operations -->
<dirac>
  <import src="../lib/index.di"/>
  
  <output>Testing MongoDB Operations...</output>
  <output>================================</output>
  
  <!-- INSERT: Add a test user -->
  <output>1. Inserting a user...</output>
  <MONGO_INSERT_ONE 
    database="testdb"
    collection="users" 
    document='{"name": "Alice", "age": 25, "email": "alice@example.com", "status": "active"}'/>
  
  <output></output>
  
  <!-- FIND: Query the user -->
  <output>2. Finding active users...</output>
  <MONGO_FIND 
    database="testdb"
    collection="users" 
    query='{"status": "active"}' 
    limit="5"/>
  
  <output></output>
  
  <!-- COUNT: Count documents -->
  <output>3. Counting all users...</output>
  <MONGO_COUNT 
    database="testdb"
    collection="users"/>
  
  <output></output>
  
  <!-- UPDATE: Modify the user -->
  <output>4. Updating user age...</output>
  <MONGO_UPDATE_ONE 
    database="testdb"
    collection="users" 
    filter='{"name": "Alice"}' 
    update='{"$set": {"age": 26}}'/>
  
  <output></output>
  
  <!-- DELETE: Remove the user -->
  <output>5. Deleting test user...</output>
  <MONGO_DELETE_ONE 
    database="testdb"
    collection="users" 
    filter='{"name": "Alice"}'/>
  
  <output></output>
  <output>✓ MongoDB operations completed!</output>
</dirac>
