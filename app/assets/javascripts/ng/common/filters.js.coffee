# Filters 
Raffler.filter "reverse", (SampleData) ->
  (text) ->
     text.split("").reverse().join("") + " : " + SampleData.message