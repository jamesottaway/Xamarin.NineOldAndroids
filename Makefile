NAME=Xamarin.NineOldAndroids
SOLUTION = $(NAME).sln
MAIN_PROJECT = NineOldAndroids
CONFIGURATIONS = Debug Release
VERSION = 0.0.1

.PHONY: all
all: clean build

.PHONY: clean
clean:
	for configuration in $(CONFIGURATIONS); do \
		xbuild $(SOLUTION) /t:clean /p:Configuration=$$configuration; \
	done

.PHONY: build
build:
	for configuration in $(CONFIGURATIONS); do \
		xbuild $(SOLUTION) /t:build /p:Configuration=$$configuration; \
	done

.PHONY: nupkg
nupkg: build
	nuget pack $(NAME).nuspec

.PHONY: release
release: nupkg
	nuget push $(NAME).$(VERSION).nupkg
