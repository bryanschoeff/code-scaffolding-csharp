class strapper.models.Field
  constructor: ->
    @name = ""
    @type = ""

  capitalizedName: ->
    util.capitalize(@name)

  sqlFieldName: ->
    "[#{@capitalizedName()}]"

  sqlParameterName: ->
    "@#{@capitalizedName()}"

  csharpName: ->
    @capitalizedName()

  csharpType: ->
    if @isString()
      "string"
    else if @type == "int"
      "int"
    else if @type == "bit"
      "bool"
    else if @type == "decimal"
      "Decimal"
    else if @type == "datetime"
      "DateTime"

  isString: ->
    @type == 'varchar' || @type == 'text'



