.PHONY: build-dev

build-dev:
	flutter clean; flutter build web --target lib/main_dev.dart --web-renderer canvaskit; firebase deploy