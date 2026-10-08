# PicoOS cheatsheet

Build the landscape PDF with:

```sh
make build-pdf
```

For automatic rebuilding while editing, run `make watch-pdf`. To open the
generated PDF in the system browser, run `make open-pdf-in-browser`.
The build only requires [Typst](https://typst.app/) and uses fonts installed with the source
distribution (`Cantarell` and `Fira Code`).

The same actions are available in VS Code through **Command Palette → Tasks:
Run Task** (`Ctrl+Shift+P`). Choose one of the tasks prefixed with `Make:`.

## Content coverage

Reviewed on 2026-10-08 against PicoOS `v1.1.5`, commit
`7647e8be5d3c7b3f9ff3f92c6a00be29ca92517c`, including changes since the
2026-09-09 cheatsheet update. Covers all 18 bundled user applications and
the 9 current shell built-ins. The footer identifies the reviewed PicoOS
version separately from this cheatsheet's release version.

## Releases

Pushing a tag whose name starts with `v` builds `picoos-cheatsheet.pdf` and
uploads it to the matching GitHub release. After committing and pushing the
release changes, create the release tag with, for example:

```sh
./create_tag.sh v1.0.0 "v1.0.0"
```

# Pico-OS_Cheatsheet
