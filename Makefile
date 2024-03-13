##
## EPITECH PROJECT, 2024
## Wolframe
## File description:
## Makefile
##

all: build
	cp $(shell stack path --local-install-root)/bin/Wolfram-exe wolfram

build:
	stack build

test:
	stack test

clean:
	stack clean
	rm -f wolfram


install_deps:
	stack solver --update-config

install_path:
	@echo "Installation path: $$(stack path --local-install-root)"