@RaffleCtrl = ($scope, Entry) ->
  $scope.entries = Entry.query()
  
  $scope.addEntry = ->
    # submit a POST request and trigger the create action
    entry = Entry.save($scope.newEntry)
    # add the entry to our list
    $scope.entries.push(entry)
    $scope.newEntry = {}
  
  $scope.removeEntry = (index) ->
    Entry.remove({id: $scope.entries[index].id}, () ->
      # If successful, remove it from our collection
      $scope.entries.splice(index, 1);
    )
    
  $scope.drawWinner = ->
    pool = []
    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) if !entry.winner
    if pool.length > 0
      entry = pool[Math.floor(Math.random() * pool.length)]
      entry.winner = true
      # When we mark an entry as a winner we need to update it in the database 
      # and we can do this by either calling Entry.update and passing in the entry
      Entry.update(entry)
      # or use 
      # entry.$update()
      
      # highlight the latest entry
      $scope.lastWinner = entry
