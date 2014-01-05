# Directives

# show error in ui
Raffler.directive "error", ($rootScope) ->
  restrict: "E"
  template: '<div class="alert-box alert" ng-show="isError">{{errorMsg}}</div>'

# potpourri
Raffler.directive "superman", () ->
  {
    restrict: "E", # Element
    template: "<div>Here I am to save the day!</div>"
  }

Raffler.directive "yell", () ->
  {
    restrict: "A", # Attribute
    link: () ->
      console.log("Er ma gerd, my first derercterve")
  }
  
Raffler.directive "enter", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mouseenter", () ->
      element.addClass(attrs.enter) # fetch attribute if 'enter' directive
      console.log("Adding " + attrs.enter + " class")
      
Raffler.directive "leave", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mouseleave", () ->
      element.removeClass(attrs.enter) # fetch attribute if 'enter' directive
      console.log("Killing " + attrs.enter + " class")

# Directive to Controller communication
Raffler.directive "click", () ->
  # defaults to 'A' if restrict not specified
  (scope, element, attrs) ->
    element.bind "mousedown", () ->
      # get function name from 'enter' attribute
      scope.$apply(attrs.click)
      
Raffler.directive "kid", () ->
  restrict: "E"
  scope:
    totesdone: "&"
  template: '<input type="text" ng-model="chore">' +
    ' {{chore}}' +
    ' <div class="button" ng-click="totesdone({chore:chore})">I\'m done!</div><br />'

Raffler.directive "drink", () ->
  restrict: "E"
  scope:
      flavor: "@" # maps to attribute
      color: "@" # maps to attribute
  template: '<div>{{flavor}} <small>{{color}}</small></div>'

Raffler.directive "phone", () ->
  restrict: "E"
  scope: 
      dial: "&"
  template: '<input type="text" ng-model="value">' +
    '<div class="button" ng-click="dial({message:value})">Call home!</div>'

# Zippy (Show/Hide Mechanism) -------------------------------------------------      
Raffler.directive "zippy", () ->
  restrict: "E"
  transclude: true
  scope:
      title: "@" # maps to attribute

  templateUrl: 'zippy.html.erb'
  link: (scope) ->
      scope.isContentVisible = false

      scope.toggleContent = () ->
          scope.isContentVisible = !scope.isContentVisible;












# ===================
# = Not working yet =
# ===================      
# Directive to Directive communication
Raffler.directive "grossdude", () ->
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

# Raffler.directive "nosepicking", () ->
#   return {
#     require: "grossdude"
#     link: (scope, element, attrs, grossdudeCtrl)->
#       grossdudeCtrl.addNosePicking()
#   }
#   
# Raffler.directive "farting", () ->
#   require: "grossdude"
#   link: (scope, element, attrs, grossdudeCtrl) ->
#     grossdudeCtrl.addFarting()
#   
# Raffler.directive "burping", () ->
#   require: "grossdude"
#   link: (scope, element, attrs, grossdudeCtrl) ->
#     grossdudeCtrl.addBurping()