COLOUR_GREEN=\033[0;32m
COLOUR_RED=\033[0;31m
COLOUR_BLUE=\033[0;34m
END_COLOUR=\033[0m

.PHONY: help
help: ## Show the help with the list of commands
	@clear
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[0;33m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

new-project: ## Initialize a new Symfony project
	@if [ -e composer.json ] || [ -d src ]; then \
		echo "$(COLOUR_RED)A project already exists in this directory. Aborting.$(END_COLOUR)"; \
		exit 1; \
	fi; 
	@echo "$(COLOUR_BLUE)Webapp project? [y/n, default: y]$(END_COLOUR)"; \
	read response; \
	response=$${response:-y}; \
	if [ "$$response" = "y" ]; then \
		echo "$(COLOUR_BLUE)Creating a new Symfony web app project...$(END_COLOUR)"; \
		symfony new new_project --version=6.4 --webapp; \
	elif [ "$$response" = "n" ]; then \
		echo "$(COLOUR_BLUE)Creating a new Symfony microservice, console application, or API...$(END_COLOUR)"; \
		symfony new new_project --version=6.4 ; \
	else \
		echo ""; \
		echo "$(COLOUR_RED)Invalid input, please enter y or n.$(END_COLOUR)"; \
		exit 1; \
	fi; \
	echo "$(COLOUR_GREEN)Cleaning up and moving project files...$(END_COLOUR)"; \
	rm -rf new_project/.git; \
	cd new_project; \
	for file in .* *; do \
		[ "$$file" != "." ] && [ "$$file" != ".." ] && mv "$$file" ..; \
	done; \
	cd ..; \
	rmdir new_project; \
	rm -rf .git; \
	git init; \
	git branch -m main ; \
	git add . ; \
	git commit -m 'initial commit'; \
	echo ""; \
	echo "$(COLOUR_GREEN)Project initialized successfully$(END_COLOUR)";

serve:  ## Launch Symfony server
	symfony serve --allow-all-ip

stop:  ## Stop Symfony server
	symfony server:stop	

test ?= src 
test-php: required_php ## Launch php unit test optionnal argument "test"
	php bin/phpunit ${test}

test-js: require_jest ## Launch npm test cmd
	npm test

check: required ## Launch PHP CS fixer/PHP Stan/PHP unit and npm run test cmd  
	@echo "$(COLOUR_BLUE)PHP CS fixer$(END_COLOUR)"
	./vendor/bin/php-cs-fixer fix src 
	@echo "$(COLOUR_BLUE)PHP Stan$(END_COLOUR)"
	vendor/bin/phpstan analyse src
	@echo "$(COLOUR_BLUE)PHP Unit$(END_COLOUR)"
	php bin/phpunit
	@echo "$(COLOUR_BLUE)NPM test$(END_COLOUR)"
	npm test 

fix ?= src 
check-fixer: require_fixer ## Launch PHP CS fixer optional argument "fix"
	./vendor/bin/php-cs-fixer fix ${fix}
analyse ?= src 

check-stan: require_stan ## Launch PHP Stan optional argument "analyse"
		vendor/bin/phpstan analyse ${analyse}

deploy: required_deploy ## Commands for deploy Symfony project
	cd public &&	rm -R assets/ || echo "public/assets not exist"
	php bin/console cache:clear
	php bin/console tailwind:build --minify
	php bin/console asset-map:compile

required: required_php require_fixer require_stan require_jest

require_jest: 
	@[ -f /node_modules/jest ] || npm install --save-dev jest;
	@echo Need configuration "https://jestjs.io/docs/getting-started"

required_php:
	@[ -f vendor/bin/phpunit ] || composer require --dev symfony/test-pack;

require_fixer:
	@[ -f vendor/bin/php-cs-fixer ] || composer require --dev friendsofphp/php-cs-fixer;

require_stan:
	@[ -f vendor/bin/phpstan ] || composer require --dev phpstan/phpstan;

required_deploy:
	composer install --no-dev --optimize-autoloader
	composer require sensiolabs/minify-bundle
