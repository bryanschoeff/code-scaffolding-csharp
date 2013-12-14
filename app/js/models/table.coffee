class strapper.models.Table
  constructor: (parent) ->
    @parent = parent
    @name = ""
    @fields = []
    @newField = new strapper.models.Field

  datatypes: ->
    ["int","decimal","varchar","text","bit"]

  addField: ->
    @fields.push @newField
    @newField = new strapper.models.Field

  # helper methods for applying formatted information to the templates

  applicationName: ->
    util.capitalize(@parent.applicationName)

  sqlTableName: ->
    result = ""
    result = "#{util.capitalize(@parent.databasePrefix)}_" if @parent.databasePrefix != ""
    "#{result}#{util.capitalize(_.pluralize(@name))}"

  sqlIdName: ->
    util.capitalize(@name)

  sqlInsertName: ->
    "#{@sqlTableName()}Insert"

  sqlUpdateName: ->
    "#{@sqlTableName()}Update"

  sqlDeleteName: ->
    "#{@sqlTableName()}Delete"

  sqlGetName: ->
    "#{@sqlTableName()}Get"

  sqlGetAllName: ->
    "#{@sqlTableName()}GetAll"

  className: ->
    util.capitalize(@name)

