#!/usr/bin/env dirac
<dirac>
  <import src="../lib/index.di" />
  
  <MONGO_INSERT_ONE database="betting" collection="test_users">
    {
      "name": "Multi Line",
      "description": "This JSON is split across multiple lines",
      "age": 42
    }
  </MONGO_INSERT_ONE>
</dirac>
