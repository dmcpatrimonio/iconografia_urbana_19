VPATH = lib
vpath %.bib .:bibliography
vpath %.csl styles
vpath %.yaml .:spec
vpath default.% lib

SRC    = $(wildcard *.md)
LATEX := $(patsubst %.md,%.tex, $(SRC))

authorea : $(LATEX)

%.tex : %.md authorea.yaml biblio.bib
	docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` \
		pandoc/latex:2.9.2.1 -o $@ -d spec/authorea.yaml $<

