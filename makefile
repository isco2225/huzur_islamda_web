peanut --extra-args "--base-href /"
git push origin gh-pages

web-release:
	flutter build web --release --base-href /
	cp build/web/index.html build/web/404.html