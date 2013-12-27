window.util = {}

util.capitalize = (phrase) ->
  phrase.split(' ').map(util.capitalizeWord).join('')

util.capitalizeWord = (word) ->
  if (word == "") 
    ""
  else 
    word[0].toUpperCase() + word.substring(1)

