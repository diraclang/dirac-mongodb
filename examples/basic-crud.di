<!-- Example: Basic MongoDB CRUD Operations -->
<dirac>
  <import src="../lib/index.di"/>
  
  <output>Testing MongoDB Operations...</output>
  <output>================================</output>
  
  <!-- INSERT: Add a test user -->
  <output>1. Inserting a user...</output>
  <MONGO_INSERT_ONE database="testdb" collection="users">
    { "name": "Alice", "age": 25, "email": "alice@example.com", "status": "active" }
  </MONGO_INSERT_ONE>
  
  <output></output>
  
  <!-- FIND: Query the user -->
  <output>2. Finding active users...</output>
  <MONGO_FIND database="testdb" collection="users" limit="5">{"status": "active"}</MONGO_FIND>
  
  <output></output>
  
  <!-- COUNT: Count documents -->
  <output>3. Counting all users...</output>
  <MONGO_COUNT database="testdb" collection="users"></MONGO_COUNT>
  
  <output></output>
  
  <!-- UPDATE: Modify the user -->
  <output>4. Updating user age...</output>
  <MONGO_UPDATE_ONE database="testdb" collection="users" filter='{"name": "Alice"}'>{"$set": {"age": 26}}</MONGO_UPDATE_ONE>
  
  <output></output>
  
  <!-- DELETE: Remove the user -->
  <output>5. Deleting test user...</output>
  <MONGO_DELETE_ONE database="testdb" collection="users" filter='{"name": "Alice"}'>
  </MONGO_DELETE_ONE>
  
  <output></output>
  <output>✓ MongoDB operations completed!</output>
</dirac>
