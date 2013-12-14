window.strapper = angular.module "strapper", []

window.strapper.models = {}

strapper.controller "Tables", ($scope) ->
  $scope.applicationName = ""
  $scope.databaseName = ""
  $scope.databasePrefix = ""
  $scope.tables = []
  $scope.newTable = new strapper.models.Table($scope)

  $scope.tab = "result-sql"

  $scope.dbPrefix = () ->
     if ($scope.databasePrefix == "")
       ""
     else
       "#{$scope.databasePrefix}_"

  $scope.addTable = () ->
    $scope.tables.push $scope.newTable
    $scope.newTable = new strapper.models.Table($scope)
    console.log $scope

  $scope.submitJson = () ->
    console.log JSON.stringify($scope.tables)

  $scope.compiledSql = () ->
    JST['app/templates/sql.hb']($scope)

  $scope.compiledClass = () ->
    JST['app/templates/csharpclass.hb']($scope)

  $scope.setTab = (tab) ->
    $scope.tab = tab

  $scope.tabVisible = (tab) ->
    $scope.tab == tab


