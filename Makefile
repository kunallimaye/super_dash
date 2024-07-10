.PHONY: clean test dev-build deploy dev-release dev-run

test:
	flutter test --coverage --test-randomize-ordering-seed random

clean:
	flutter clean

dev-build:
	flutter build web --target lib/main_dev.dart --web-renderer canvaskit

deploy:
	firebase deploy

dev-release: clean dev-build deploy

dev-run:
	flutter run -d chrome --target lib/main_dev.dart
