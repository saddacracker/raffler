@AvengersCtrl = ($scope, Avengers) ->
  $scope.avengers = Avengers
  $scope.loadMoreTweets = () ->
    alert("Loading Tweets From AvengersCtrl")