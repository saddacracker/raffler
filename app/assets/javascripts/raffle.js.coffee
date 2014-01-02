app = angular.module("Raffler", ["ngResource"])

# Directives
app.directive "superman", () ->
  {
    restrict: "E", # Element
    template: "<div>Here I am to save the day!</div>"
  }

app.directive "yell", () ->
  {
    restrict: "A", # Attribute
    link: () ->
      alert("Er ma gerd")
  }
  
app.directive "enter", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mouseenter", () ->
      element.addClass(attrs.enter) # fetch attribute if 'enter' directive
      console.log("Adding " + attrs.enter + " class")
      
app.directive "leave", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mouseleave", () ->
      element.removeClass(attrs.enter) # fetch attribute if 'enter' directive
      console.log("Killing " + attrs.enter + " class")

# Filters 
app.filter "reverse", (SampleData) ->
  (text) ->
     text.split("").reverse().join("") + " : " + SampleData.message

# Create a resource to pass into RaffleCtrl
app.factory "Entry", ($resource) ->
  $resource("/entries/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  
app.factory "SampleData", () ->
  {message: "I'm data from a service"}
  
app.factory "SampleSharedData", () ->
  {message: "Sample Shared Data"}
  
app.factory "Avengers", () ->
  Avengers = {}
  Avengers.cast = [
    {name: "Calvin Cardwell", character: "Hommie"},
    {name: "Emmitt Cardwell", character: "Tiger"},
    {name: "Seddie LebLanc", character: "Seddie Spaghetti"},
    {name: "Parker LeBlanc", character: "Sparkler"}
  ]
  return Avengers

# @ makes it accessible outside this file
@RaffleCtrl = ($scope, Entry) ->
  $scope.entries = Entry.query()
  
  $scope.addEntry = ->
    # submit a POST request and trigger the create action
    entry = Entry.save($scope.newEntry)
    # add the entry to our list
    $scope.entries.push(entry)
    $scope.newEntry = {}
    
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


@SimpleCtrl = ($scope, SampleData) ->
  $scope.data = SampleData
  $scope.reversedMessage = (message) ->
    message.split("").reverse().join("")
  
@SimpleCurrencyCtrl = ($scope) ->
  
@AvengersCtrl = ($scope, Avengers) ->
  $scope.avengers = Avengers
  
