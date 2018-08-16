build:
	elm make App.elm --output=app.js

live:
	elm live app.elm --output=app.js --open

clean:
	rm app.js
