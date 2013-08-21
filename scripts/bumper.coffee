fs = require 'fs'
path = require 'path'

filepath = path.join __dirname, "../package.json"
json = JSON.parse (fs.readFileSync filepath, "utf-8")

version = json.version
cs_version = json.dependencies['coffee-script']

[major,minor,patch] = version.split '.'

switch process.argv[2]
	when '--major'
		major++
		minor = 0
		patch = 0
		break
	when '--minor'
		minor++
		patch = 0
		break
	when '--patch'
		patch++
		break
	when '--version'
		console.log version
		process.exit()
	when '--csversion'
		console.log cs_version
		process.exit()

new_version = "#{major}.#{minor}.#{patch}"
console.log "Updating `package.json` version: '#{version}' ~> '#{new_version}'"

# updating package.json
filepath = path.join __dirname, "../package.json"
contents = fs.readFileSync filepath, 'utf-8'
search = /"version":\s"[0-9]+.[0-9]+.[0-9]+"/
replace = "\"version\": \"#{new_version}\""
fs.writeFileSync filepath, (contents.replace search, replace)