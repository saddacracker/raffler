@TestTickleCtrl = ($scope) ->
  this.model = {
      message: "Welcome! Get your tests tickled!"
  }
  # https://egghead.io/lessons/angularjs-an-alternative-approach-to-controllers
  return $scope.TestTickleCtrl = this;