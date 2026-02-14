#!/usr/bin/env dirac
<dirac>
  <import src="../lib/index.di" />
  
  <subroutine name="TEST_BODY_EXTRACT">
    <defvar name="body"><parameters select="*" /></defvar>
    <eval>console.log('Body type:', typeof body);</eval>
    <eval>console.log('Body value:', body);</eval>
    <eval>console.log('Body JSON:', JSON.stringify(body));</eval>
  </subroutine>
  
  <TEST_BODY_EXTRACT>
    {
      "name": "Test User",
      "age": 30
    }
  </TEST_BODY_EXTRACT>
</dirac>
