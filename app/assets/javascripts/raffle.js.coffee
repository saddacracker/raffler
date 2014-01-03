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

# Directive to Controller communication
app.directive "click", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mousedown", () ->
      # get function name from 'enter' attribute
      scope.$apply(attrs.click)


# Directive to Directive communication
app.directive "grossdude", () ->
  return {
    restrict: "E",
    scope:{},
    controller: ($scope)->
      $scope.abilities = [] #store our superhero's abilities
      @addNosePicking = ()->
        $scope.abilities.push("Nose Picking")
      @addFarting = ()->
        $scope.abilities.push("Farting")
      @addBurping = ()->
        $scope.abilities.push("Burping")

    link: (scope, element) ->
      element.addClass("button")
      element.bind "mousedown", () ->
         console.log(scope.abilities)
  }
       

# app.directive "nosepicking", () ->
#   return {
#     require: "grossdude"
#     link: (scope, element, attrs, grossdudeCtrl)->
#       grossdudeCtrl.addNosePicking()
#   }
#   
# app.directive "farting", () ->
#   require: "grossdude"
#   link: (scope, element, attrs, grossdudeCtrl) ->
#     grossdudeCtrl.addFarting()
#   
# app.directive "burping", () ->
#   require: "grossdude"
#   link: (scope, element, attrs, grossdudeCtrl) ->
#     grossdudeCtrl.addBurping()
  

  
  
# Filters 
app.filter "reverse", (SampleData) ->
  (text) ->
     text.split("").reverse().join("") + " : " + SampleData.message

# Factories
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


@SimpleCtrl = ($scope, SampleData) ->
  $scope.data = SampleData
  $scope.reversedMessage = (message) ->
    message.split("").reverse().join("")
  
@SimpleCurrencyCtrl = ($scope) ->
  $scope.loadMoreTweets = () ->
    alert("Loading Tweets From SimpleCurrencyCtrl")
  
@AvengersCtrl = ($scope, Avengers) ->
  $scope.avengers = Avengers
  $scope.loadMoreTweets = () ->
    alert("Loading Tweets From AvengersCtrl")


# Directive (Isolate Scope) -------------------------------------------------

# Controller
@ChoreCtrl = ($scope) -> 
  $scope.logChore = (chore) ->
    alert(chore + " is done!")
    
# Directive
app.directive "kid", () ->
  restrict: "E"
  scope:
    totesdone: "&"
  template: '<input type="text" ng-model="chore">' +
    ' {{chore}}' +
    ' <div class="button" ng-click="totesdone({chore:chore})">I\'m done!</div><br />'
      


# Directive (Isolate Scope @) -------------------------------------------------

@DrinkCtrl = ($scope) ->
  $scope.ctrlFlavor = "blackberry"
  $scope.ctrlColor = "blue"

app.directive "drink", () ->
  restrict: "E"
  scope:
      flavor: "@" # maps to attribute
      color: "@" # maps to attribute
  template: '<div>{{flavor}} <small>{{color}}</small></div>'
  

# Directive (Isolate Scope &) -------------------------------------------------
@CallHomeCtrl = ($scope) ->
  $scope.callHome = (message) ->
    alert(message)

app.directive "phone", () ->
  restrict: "E"
  scope: 
      dial: "&"
  template: '<input type="text" ng-model="value">' +
    '<div class="button" ng-click="dial({message:value})">Call home!</div>'
