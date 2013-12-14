window.util = {}

util.capitalize = (phrase) ->
  phrase.split(' ').map(util.capitalizeWord).join('')

util.capitalizeWord = (word) ->
  word[0].toUpperCase() + word.substring(1)

