#Define the app and dependencies
TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

#Setup the angular router
TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when '/',
			templateUrl: "index.html",
			controller: "todo_items_controller" #taco with below
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true)




]


#todo controller
TodoApp.controller "todo_items_controller", ["$scope", "$http", ($scope, $http) ->
  $scope.todo_items = []

  $scope.getItems = ->
  	#make a GET request to /todo_items.json
  	$http.get("/todo_items.json").success (data) ->
  		$scope.todo_items = data
  $scope.getItems()

  $scope.addItem = ->
  	$http.post("/todo_items.json", $scope.newItem).success (data) ->
  		$scope.newItem = {}
  		$scope.todo_items.push(data)

  $scope.deleteItem = (todo_item) ->
  	$http.delete("/todo_items/#{todo_item.id}.json").success (data) ->
  		conf = confirm "Are you sure?"
  		if conf
  			console.log("todo_item",todo_item)
  			$scope.todo_items.splice($scope.todo_items.indexOf(todo_item),1)

  $scope.editItem = (todo_item) ->
  	this.checked = false
  	$http.put("/todo_items/#{todo_item.id}.json", todo_item).success (data) ->
  		console.log(data)

]

# Define Config for CSRF token
#reivew
TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]