TYPST ?= typst
SOURCE := cheatsheet.typ
PDF := picoos-cheatsheet.pdf

.PHONY: all clean watch

all: $(PDF)

$(PDF): $(SOURCE)
	$(TYPST) compile $(SOURCE) $(PDF)

watch:
	$(TYPST) watch $(SOURCE) $(PDF)

clean:
	$(RM) $(PDF)
