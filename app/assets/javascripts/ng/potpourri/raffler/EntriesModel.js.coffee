Raffler.factory "Entry", ($resource) ->
  $resource("/entries/:id.json", {id: "@id"}, {update: {method: "PUT"}})