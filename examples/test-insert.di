<dirac>
  <import src="../lib/index.di"/>
  
  <output>Test INSERT:</output>
  <MONGO_INSERT_ONE database="betting" collection="test_users">
    { "test": "value" }
  </MONGO_INSERT_ONE>
  
  <output>Done</output>
</dirac>
