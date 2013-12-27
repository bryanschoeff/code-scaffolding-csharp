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
    if $scope.newTable.name != ""
      $scope.tables.push $scope.newTable
      $scope.newTable = new strapper.models.Table($scope)

  $scope.submitJson = () ->
    sql = new Blob([$scope.compiledSql()], {type: "text/plain;charset=utf-8"})
    saveAs(sql, "#{$scope.databaseName}.sql")

    csharp = new Blob([$scope.compiledClass()], {type: "text/plain;charset=utf-8"})
    saveAs(csharp, "#{$scope.databaseName}.cs")
    console.log JSON.stringify($scope.tables)

  $scope.compiledSql = () ->
    JST['app/templates/sql.hb']($scope)

  $scope.compiledClass = () ->
    JST['app/templates/csharpclass.hb']($scope)

  $scope.setTab = (tab) ->
    $scope.tab = tab

  $scope.tabVisible = (tab) ->
    $scope.tab == tab

  $scope.sqlDatabaseName = () ->
    util.capitalize($scope.databaseName)

