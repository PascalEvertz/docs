# You can set these variables from the command line:
SPHINXOPTS  := -W
SPHINXBUILD := sphinx-build
PAPER       :=

# Internal variables
ROOT            = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d _build/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

.PHONY: all clean html check themes

all: html

clean:
	-rm -rf _build/*
	-rm -rf authors.rst

_build/doctrees:
	mkdir -p _build/doctrees

html: authors.rst _build/doctrees themes
	mkdir -p _build/html
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) _build/html
	@echo
	@echo "Build finished.  The HTML pages are in _build/html."

linkcheck: _build/doctrees
	mkdir -p _build/linkcheck
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) _build/linkcheck
	@echo
	@echo "Link check complete.  Look for any errors in the above output " \
	      "or in _build/linkcheck/output.txt."

themes:
	@true

authors.rst:
	git log --use-mailmap --format="* %aN" | sort -uf > $@
