test: lint
	@NODE_ENV=test ./node_modules/.bin/mocha $(MOCHA_OPTS) test/*Spec.js

lint:
	@ find . -name "*.js" \
		-not -path "./node_modules/*" \
		-not -path "./coverage/*" -print0 | \
		xargs -0 ./node_modules/eslint/bin/eslint.js

test-cov: lint
	@NODE_ENV=test node $(MOCHA_OPTS) \
		node_modules/.bin/istanbul cover \
		./node_modules/.bin/_mocha \
		-- -u exports \
		test/*Spec.js

open-cov:
	open coverage/lcov-report/index.html

test-travis: lint
	@NODE_ENV=test node $(MOCHA_OPTS) \
		./node_modules/.bin/istanbul cover \
		./node_modules/.bin/_mocha \
		--report lcovonly \
		-- -u exports \
		--bail

.PHONY: test lint test-cov open-cov test-travis
