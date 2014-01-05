# Factories
Raffler.factory "SampleData", () ->
  {message: "I'm data from a service"}


# Setting Up The Root View to Handle Errors -------------------------------------------------

# main controller 
#  placeholder for rootScope stuff, routeErrors...
Raffler.controller "AppCtrl", ($rootScope, $scope) ->
  # handle if the promise to teh router wasn't fulfilled
  $rootScope.$on "$routeChangeError", (event, current, previous, rejection) ->
    $scope.isError = true
    $scope.errorMsg = rejection

Raffler.potpourriCtrl = Raffler.controller "PotpourriCtrl", ($scope, $route) ->
  console.log($route);
  this.model = {
    message: "I'm a great app!"
  }
  return $scope.PotpourriCtrl = this;

# make this method accessable
Raffler.potpourriCtrl.loadData = ($q, $timeout) ->
  defer = $q.defer()
  $timeout () ->
    defer.resolve "YOU WERE REJECTED", 500 # resolve/reject
  return defer.promise

# End Setting Up The Root View to Handle Errors -------------------------------------------------
  

# ng-View ------------------------------------------------- 
# @ makes it accessible outside this file          


@SimpleCtrl = ($scope, SampleData) ->
  $scope.data = SampleData
  $scope.reversedMessage = (message) ->
    message.split("").reverse().join("")
  
@SimpleCurrencyCtrl = ($scope) ->
  $scope.loadMoreTweets = () ->
    alert("Loading Tweets From SimpleCurrencyCtrl")


# Directive (Isolate Scope) -------------------------------------------------

# Controller
@ChoreCtrl = ($scope) -> 
  $scope.logChore = (chore) ->
    alert(chore + " is done!")
      


# Directive (Isolate Scope @) -------------------------------------------------

@DrinkCtrl = ($scope) ->
  $scope.ctrlFlavor = "blackberry"
  $scope.ctrlColor = "blue"


  

# Directive (Isolate Scope &) -------------------------------------------------
@CallHomeCtrl = ($scope) ->
  $scope.callHome = (message) ->
    alert(message)
