build:
	elm make src/App.elm --output=app.js --optimize

reactor:
	elm reactor

clean:
	rm app.js
