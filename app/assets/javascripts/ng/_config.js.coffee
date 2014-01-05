# Routes
Raffler.config ($routeProvider) ->
  $routeProvider
  .when('/',
    templateUrl: "/assets/ng/views/potpourri/potpourri.html",
    controller: "PotpourriCtrl",
    resolve:
      # this promise from ViewCtrl has to be resolved before loading
      loadData: Raffler.potpourriCtrl.loadData 
  )
  .when( '/testickle',
    templateUrl: "/assets/ng/views/test_tickle.html"
    controller: "TestTickleCtrl"
  ).when( '/pizza',
    templateUrl: "/assets/ng/views/pizza.html"
  ).otherwise(
    redirectTo: "/"
  )
