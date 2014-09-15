#Define the app and dependencies
TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

#Setup the angular router
TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when '/',
			templateUrl: "index.html",
			controller: "todo_items_controller1" #taco with below
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true)




]


#todo controller
TodoApp.controller "todo_items_controller1", ["$scope", "$http", ($scope, $http) ->
  $scope.todo_items = []

  $scope.getItems = ->
  	# make a GET request to /todo_items.json
  	$http.get("/todo_items.json").success (data) ->
  		$scope.todo_items = data
  $scope.getItems()

  $scope.addItem = ->
  	$scope.newItem.completed = false
  	$http.post("/todo_items.json", $scope.newItem).success (data) ->
  		$scope.newItem = {}
  		$scope.todo_items.push(data)

  $scope.deleteItem = (todo_item) ->
  	conf = confirm "Are you sure?"
  	if conf
  		$http.delete("/todo_items/#{todo_item.id}.json").success (data) ->
  			console.log("todo_item",todo_item)
  			$scope.todo_items.splice($scope.todo_items.indexOf(todo_item),1)

  $scope.editItem = (todo_item) ->
  	this.checked = false
  	$http.put("/todo_items/#{todo_item.id}.json", todo_item).success (data) ->
  		console.log(data)

  $scope.completedItem = (todo_item) ->
  	# todo_item.completed

  	todo_item.completed = !todo_item.completed
  	console.log(todo_item)
  	$http.put("/todo_items/#{todo_item.id}.json", todo_item).success (data) ->


]

# Define Config for CSRF token
#reivew
TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]