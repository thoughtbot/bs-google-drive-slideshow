all:
	npm run build
	./node_modules/webpack/bin/webpack.js
	cp ./dist/bundle.js ~/code/google-drive-slideshow/src
