build:
	elm make src/App.elm --output=app.js

live:
	elm live src/App.elm --output=app.js --open

clean:
	rm app.js
