#let paper = rgb("ffffff")
#let panel = rgb("ffffff")
#let raised = rgb("f1f8f8")
#let soft = rgb("edf6f6")
#let ink = rgb("17313a")
#let muted = rgb("637983")
#let teal = rgb("078b98")
#let green = rgb("2f8f61")
#let coral = rgb("d9534f")
#let amber = rgb("c8861a")
#let navy = rgb("183039")
#let border = rgb("cddfe1")
#let release_version = read("config/cheatsheet-release.txt").trim()

#set page(
  paper: "a4",
  flipped: true,
  margin: (left: 6.5mm, right: 6.5mm, top: 6mm, bottom: 7mm),
  fill: paper,
  footer: context [
    #set text(font: "Cantarell", size: 4.8pt, fill: muted)
    #line(length: 100%, stroke: 0.4pt + border)
    #v(1.2pt)
    #grid(
      columns: (1fr, auto, auto),
      gutter: 5pt,
      [PicoOS · shell and bundled user applications],
      [runtime overview],
      [#release_version],
    )
  ],
)
#set text(font: "Cantarell", size: 9.1pt, fill: ink)
#set par(leading: 0.43em, spacing: 2.5pt)
#show raw: set text(font: "Fira Code", size: 7.1pt)
#show strong: set text(fill: teal)

#let mono(body) = box(
  fill: soft,
  stroke: 0.3pt + border,
  radius: 1pt,
  inset: (x: 1.7pt, y: 0.5pt),
  text(font: "Fira Code", size: 7pt, fill: rgb("17545c"), body),
)

#let codeblock(body) = block(
  width: 100%,
  fill: navy,
  stroke: 0.45pt + teal.transparentize(45%),
  radius: 1.5pt,
  inset: 2.8pt,
  text(font: "Fira Code", size: 7.05pt, fill: rgb("e7f7f5"), body),
)

#let card(title, body, color: teal) = block(
  width: 100%,
  fill: panel,
  stroke: 0.45pt + border,
  radius: 2pt,
  inset: (left: 3.6pt, right: 3.6pt, top: 4pt, bottom: 5.3pt),
  breakable: true,
  [
    #grid(
      columns: (1.8pt, 1fr),
      gutter: 3pt,
      rect(width: 1.8pt, height: 7.5pt, radius: 0.8pt, fill: color),
      text(size: 9.8pt, weight: "bold", fill: ink, title),
    )
    #v(1.5pt)
    #body
  ],
)

#let entry(left, right) = grid(
  columns: (auto, 1fr),
  gutter: 2.3pt,
  align: top,
  mono(left),
  right,
)

#let signal(number, name, effect) = grid(
  columns: (14pt, 50pt, 1fr),
  gutter: 2pt,
  align: top,
  text(font: "Fira Code", size: 7pt, fill: coral, number),
  text(font: "Fira Code", size: 7pt, fill: rgb("17545c"), name),
  effect,
)

#block(
  width: 100%,
  fill: raised,
  stroke: 0.65pt + teal.transparentize(45%),
  radius: 2.5pt,
  inset: (x: 6pt, y: 4pt),
)[
  #grid(
    columns: (1fr, auto),
    align: (left, right),
    [
      #box(fill: teal, radius: 1.2pt, inset: (x: 4pt, y: 1pt))[
        #text(size: 5pt, weight: "bold", fill: white, tracking: 0.6pt)[PICOOS]
      ]
      #h(4pt)
      #text(size: 14.5pt, weight: "bold", fill: ink)[User cheatsheet]
    ],
    text(size: 5.3pt, fill: muted)[Start · shell · files · jobs · signals · commands],
  )
]
#v(3.5pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 4mm,
  align: top,
  [
    #card([Start], [
      #entry([Linux/macOS], [`./download-tools.sh` → `./start-picoos.sh`])
      #entry([Windows], [`.\download-tools.ps1` → `.\start-picoos.ps1`])
      #entry([Android], [run the Linux scripts in Termux])
      #entry([Debug TUI], [`c` boot → `V` terminal → `Ctrl+]` back])
      #entry([No TUI], [`--notui` / PowerShell `-NoTui`])
    ])

    #card([Shell syntax], [
      #entry([NAME.bin], [search `PATH` (default `/user`)])
      #entry([PATH/NAME], [load directly])
      #entry([#raw("'...' / \"...\"")], [one argument])
      #entry([`$NAME`], [value; unknown → empty])
      #entry([`$?` / `$!`], [last status / tracked PID])
      Variables expand in arguments, even in single quotes; not in command names or redirect paths.
    ])

    #card([Line editing], [
      #entry([Enter], [run; maximum 79 characters])
      #entry([Backspace / Del], [erase character])
      #entry([Ctrl+U / Ctrl+W], [erase line / word])
      #entry([↑ / ↓], [8 recent commands; ↓ restores draft])
      #entry([Tab], [insert one space; no completion])
      #entry([← / →], [not supported])
    ], color: green)

    #card([Shell built-ins], [
      #entry([cd DIR], [change directory])
      #entry([export N=V], [set variable])
      #entry([eval CMD], [evaluate command])
      #entry([load PATH], [load without running; print PID])
      #entry([run PID [ARGS]], [run loaded PID])
      #entry([unload PID], [remove process])
      #entry([fg / bg], [continue tracked job])
      #entry([exit], [end shell; init starts a fresh one])
      #entry([run-shell-tests FILE], [internal test runner])
    ])

    #card([Environment], [
      #entry([export N=V], [session + future children])
      #entry([export N=], [empty, still defined])
      #entry([unset], [not available; `exit` resets session])
      Startup defaults: `/config/environment.txt`.
    ], color: green)

    #card([Results], [
      #entry([`$?`], [last command / foreground result])
      #entry([0 / 1], [success / usual error])
      Built-ins set 0/1. External `CMD &` keeps `$?`; `run PID &` sets 0 on success.
    ], color: green)

    #card([Not supported], [
      Wildcards · aliases · `$(...)` · `;` · general escapes · bare `N=V` assignments
    ], color: amber)
  ],
  [
    #card([Application help], [
      Use a sole `-h` / `--help` for all 18 applications except `echo.bin`. Also: `cd -h`.
    ], color: amber)

    #card([Print, inspect & edit], [
      #entry([echo.bin TEXT...], [print; literal `\n` → newline])
      #entry([cat.bin [FILE...]], [print files or stdin])
      #entry([pwd.bin], [current directory])
      #entry([ls.bin [-a] [DIR]], [list; `-a` includes hidden])
      #entry([ps.bin], [PID + binary path])
      #entry([uname.bin], [PicoOS version])
      #entry([sed.bin EXPR], [edit stdin → stdout])
    ], color: green)

    #card([Create, copy & remove], [
      #entry([touch.bin FILE...], [create/update])
      #entry([cp.bin SRC DST], [copy file])
      #entry([mv.bin SRC DST], [move/rename file or directory])
      #entry([mkdir.bin DIR...], [create directories])
      #entry([rm.bin FILE...], [remove files])
      #entry([rmdir.bin DIR...], [remove empty directories])
    ], color: green)

    #card([Processes & power], [
      #entry([count.bin [DELAY]], [count forever; default `25000`])
      #entry([kill.bin [SIG] PID], [default `SIGKILL`])
      #entry([poweroff.bin], [halt])
      #entry([reboot.bin], [full PicoOS reboot])
      #entry([shell.bin], [new shell])
      `DELAY` ≥ 0 counts loop iterations, not milliseconds.
    ], color: coral)

    #card([`sed.bin` expressions], [
      #entry([#raw("'5iTEXT'")], [insert before line 5])
      #entry([#raw("'5cTEXT'")], [replace line 5])
      #entry([#raw("'5aTEXT'")], [append after line 5])
      #entry([#raw("'/word/iTEXT'")], [insert before each matching line])
      #entry([#raw("'s/old/new/'")], [first literal match per line])
      Input via `< FILE` or `|`; no file operand or regex.
      #codeblock[#raw("sed.bin '2cNEW' < a.txt > b.txt")]
    ], color: coral)

    #card([Type a file with `cat.bin`], [
      #codeblock[#raw("cat.bin > notes.txt")]
      Enter writes a line; Backspace / Del edits; Ctrl+D finishes input.
    ], color: coral)

    #card([Command limits], [
      `echo`: no `-n` · `mkdir`: no `-p` · `rm`: no `-r/-f` · `ls`: no sorting, long or recursive mode
    ], color: amber)
  ],
  [
    #card([Redirection], [
      #entry([CMD < FILE], [stdin from file])
      #entry([CMD > FILE], [replace stdout file])
      #entry([CMD >> FILE], [append stdout file])
      #entry([CMD 2> FILE], [replace stderr file])
      #entry([CMD 2>> FILE], [append stderr file])
      Put redirects after arguments, with a space before each operator; optional `&` last. Also works with `run`.
      #codeblock[#raw("cat.bin < a.txt > b.txt 2> err.txt\ncat.bin missing 2>> err.txt\ncat.bin missing 2> /device/null.dev")]
      `/device/null.dev` discards output; `/device/terminal.dev` writes to the terminal.
    ])

    #card([Pipelines & command files], [
      #codeblock[#raw("cat.bin a.txt | sed.bin 's/old/new/'\nshell.bin < commands.txt")]
      One `|`: left command finishes before right starts. Use finite external commands, without `&`, in a writable directory. Command files: one command per line; EOF exits.
    ], color: green)

    #card([Jobs & terminal keys], [
      #entry([CMD &], [start background; set `$!`])
      #entry([Ctrl+Z], [`SIGTSTP`; remember PID])
      #entry([fg], [foreground + `SIGCONT`])
      #entry([bg], [background + `SIGCONT`])
      #entry([Ctrl+C], [`SIGINT` foreground job])
      #entry([SIGTTIN], [background terminal read stops])
      One tracked job only; use `fg` for terminal input.
    ])

    #card([`kill.bin` signals], [
      #signal([0], [probe], [check PID only])
      #signal([2], [SIGINT], [terminate → 130])
      #signal([9], [SIGKILL], [terminate → 137])
      #signal([18], [SIGCONT], [continue])
      #signal([19], [SIGSTOP], [stop → 147])
      #signal([20], [SIGTSTP], [stop → 148])
      #signal([21], [SIGTTIN], [stop input → 149])
      #codeblock[#raw("kill.bin 42          # SIGKILL\nkill.bin SIGTSTP 42\nkill.bin 18 42      # SIGCONT\nkill.bin 0 42       # probe")]
      Only these signals; names/numbers have no leading `-`. Fixed actions. Arrows show result status.
    ], color: coral)

  ],
)
