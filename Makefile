TARGET=public/app.js
TARGET_MIN=public/app.min.js

all: build min

build:
	elm make src/Main.elm --output=${TARGET} --optimize

dev:
	elm make src/Main.elm --output=${TARGET_MIN}

min:
	uglifyjs ${TARGET} --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' \
	| uglifyjs --mangle --output=${TARGET_MIN}

live:
	elm-live src/Main.elm --pushstate -d public

reactor:
	elm reactor

clean:
	rm ${TARGET} ${TARGET_MIN}
