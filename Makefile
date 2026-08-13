TYPST ?= typst
SOURCE := cheatsheet.typ
PDF := picoos-cheatsheet.pdf

.PHONY: build-pdf watch-pdf clean-generated-pdf open-pdf-in-browser

build-pdf: $(PDF)

$(PDF): $(SOURCE)
	$(TYPST) compile $(SOURCE) $(PDF)

watch-pdf:
	$(TYPST) watch $(SOURCE) $(PDF)

clean-generated-pdf:
	$(RM) $(PDF)

open-pdf-in-browser: $(PDF)
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(PDF); \
	elif command -v open >/dev/null 2>&1; then \
		open $(PDF); \
	else \
		echo "No supported browser opener found (tried xdg-open and open)." >&2; \
		exit 1; \
	fi
