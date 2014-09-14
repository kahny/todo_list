#Define the app and dependencies
TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

#Setup the angular router
TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when '/',
			templateUrl: "index.html",
			controller: "TodoCtrl"
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true)




]


#todo controller
TodoApp.controller "TodoCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.todo_items = []
]