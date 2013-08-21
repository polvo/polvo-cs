CS=node_modules/coffee-script/bin/coffee
VERSION=`$(CS) scripts/bumper.coffee --version`

setup:
	@npm install



watch:
	@$(CS) -bwco ./ src/index.coffee

build:
	@$(CS) -bco ./ src/index.coffee



bump.minor:
	@$(CS) scripts/bumper.coffee --minor

bump.major:
	@$(CS) scripts/bumper.coffee --major

bump.patch:
	@$(CS) scripts/bumper.coffee --patch



publish:
	git tag $(VERSION)
	git push origin $(VERSION)
	git push origin master
	npm publish

re-publish:
	git tag -d $(VERSION)
	git tag $(VERSION)
	git push origin :$(VERSION)
	git push origin $(VERSION)
	git push origin master -f
	npm publish -f