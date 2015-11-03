
unique = require "array-unique"

# Data source
{getQuerySuggestions} = require "google-autocomplete"

# English stuff
{Lexer, Tagger} = require "pos"
lexer = new Lexer()
tagger = new Tagger()

pluralize = require "pluralize"

find_out = (query, {avoid, capture}, callback)->
	getQuerySuggestions query, (err, suggestions)->
		return callback err if err
		# console.log JSON.stringify suggestions, null, 4
		
		captured = []
		for {suggestion, type, relevance} in suggestions when type is "QUERY"
			words = lexer.lex suggestion
			tagged_words = tagger.tag words
			
			# console.log {suggestion, type, relevance}
			# for [word, tag] in tagged_words
			# 	console.log "#{word} /#{tag}"
			
			okay = yes
			okay = no for [word, tag] in tagged_words when (not (word in query.split " ")) and tag.match avoid
			# console.log "okay? #{okay}"
			if okay
				captured_words = (word for [word, tag] in tagged_words when (not (word in query.split " ")) and tag.match capture)
				# console.log "captured_words: #{captured_words}"
				
				if captured_words.length
					captured.push captured_words.join " "
		
		callback null, unique captured

research = (subject, callback)->
	subject_singular = pluralize subject, 1
	subject_plural = pluralize subject, 2
	# if subject is "you" then subject_plural = "you"
	
	# console.log "Hey look, some #{subject_plural}!"
	# console.log "Hey look, a #{subject_singular}!"
	# return
	
	# TODO: avoid "have", e.g. Why do sandstorms... have?
	find_out "Why are #{subject_plural}", avoid: /NN|VBN|IN/, capture: /JJ/,
		(err, subject_adjectives)->
			return callback err if err
			# console.log "\n\n", subject_adjectives
			
			find_out "Why do #{subject_plural}", avoid: /IN/, capture: /V|NN/,
				(err, subject_verbs)->
					return callback err if err
					# console.log "\n\n", subject_verbs
					subject_verbs = subject_verbs.filter (v)-> not v.match /ing|have /
					
					callback null,
						plural: subject_plural
						singular: subject_singular
						verbs: subject_verbs
						adjectives: subject_adjectives

module.exports = research
