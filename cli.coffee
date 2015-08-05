
research = require "./research"
output = require "./output"

[node, this_file_path, subject] = process.argv

if subject
	research subject, (err, subject)->
		return console.error err if err
		output subject
else
	console.error "Argument required: subject to research"
	console.error "Usage: research <subject>"
	process.exit(1)
