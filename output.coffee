
# Output (optional)
# {tts} = ((try require "node-tts-google") ? {})

# English stuff
_tensify = require "tensify"

tensify = (verbial_phrase, how)->
	words = verbial_phrase.split " "
	[verb, more...] = words
	[_tensify(verb)[how], more...].join " "

a_an = (what)->
	if what.match /^\s*[aeiou]/
		"an #{what}"
	else
		"a #{what}"

# Array helpers
unique = require "array-unique"
choose = (arr)->
	arr[~~(Math.random() * arr.length)]

# String helpers
String::ucfirst = ->
	@charAt(0).toUpperCase() + @slice(1)


# Output information about a subject
module.exports = (subject)->

	o = (text)->
		console.log text
		# tts?.speak? text
		# delete tts.speak

	o "Hey, look, #{a_an subject.singular}!"
	o ""
	o "I think #{subject.plural} are...\n   #{subject.adjectives.join "\n   "}"
	o ""
	o "What do #{subject.plural} do? They...\n   #{subject.verbs.join "\n   "}"

	some_adjectives = ->
		unique (choose subject.adjectives for [0..Math.random()*3])

	some_action = ->
		choose subject.verbs

	o ""
	for [0..5]
		o "There is #{a_an some_adjectives().join ", "} #{subject.singular}."

	o ""
	for [0..5]
		o "#{a_an some_adjectives().join ", "} #{subject.singular} #{tensify(some_action(), "past")}.".ucfirst()

