.INTERMEDIATE: test-unwrapped.js

test.js: Test.elm Test/*.elm
	elm-make Test.elm --output test-unwrapped.js
	./elm-io.sh test-unwrapped.js test.js

.PHONY: test_prepare test

test_prepare:
	elm-package install evancz/automaton
	npm install jsdom

test: test.js
	node $<
