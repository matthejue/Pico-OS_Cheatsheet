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
#let picoos_version = "v1.1.5"

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
      [PicoOS #picoos_version · checked 2026-10-08],
      [cheatsheet #release_version],
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
      #entry([Linux/macOS], [`./start-picoos.sh`])
      #entry([Windows], [`.\start-picoos.ps1` (PowerShell)])
      #entry([Android], [`./start-picoos.sh` in Termux])
      If RETI Emulator or PicoC Compiler is missing, the launcher offers to run #box[`./download-tools.sh`] / #box[`.\download-tools.ps1`] to fetch it. Manual tool download is optional.
      #entry([Debug TUI], [`c` + Enter boot → `V` raw terminal; `Ctrl+]` back])
      #entry([DMA], [`--dma` / `-Dma` (both `-M`); otherwise prompted])
      #entry([No TUI], [`--notui` / `-NoTui` (both `-N`)])
      #entry([Help], [`--help` / `-Help` (both `-h`)])
      #entry([Emulator], [`--reti-emulator PATH` / `-RetiEmulator PATH`])
      #entry([Extra options], [`-- EMULATOR_ARGS...`])
      Option pairs: shell / PowerShell. DMA loads program words into SRAM while the CPU can run other work.
    ])

    #card([Shell syntax], [
      #entry([NAME.bin], [search colon-separated `PATH` (default `/user`)])
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
      Terminal buffer: 128 bytes; new input is dropped when full.
    ], color: green)

    #card([Shell built-ins], [
      #entry([cd DIR], [change directory])
      #entry([export N=V], [set variable])
      #entry([eval CMD], [evaluate command])
      #entry([load PATH], [load without running; print PID])
      #entry([run PID [ARGS]], [run loaded PID])
      #entry([unload PID], [terminate/remove a non-current process])
      #entry([fg / bg], [continue tracked job])
      #entry([exit], [end shell; init starts a fresh one])
    ])

    #card([Environment & results], [
      #entry([export N=V], [this shell + future children; expands values])
      #entry([export N=], [empty, still defined])
      #entry([unset], [not available; `exit` resets session])
      Startup defaults: `/config/environment.txt`.
      Loading bars: #box[`export PICOOS_LOADING_BAR=true`]. Any defined value enables them, even empty.
      #entry([`$?`], [last command / foreground result])
      #entry([0 / 1], [success / usual error])
      Built-ins set 0/1. External `CMD &` keeps `$?`; `run PID &` sets 0 on success.
    ], color: green)
  ],
  [
    #card([Release archive folders], [
      The extracted archive directory is PicoOS `/`.
      #entry([/boot], [`bootloader.reti`: loads and starts the kernel])
      #entry([/kernel], [`kernel.bin` + memory-layout and debug metadata])
      #entry([/system], [`init.bin`: starts and restarts the shell])
      #entry([/user], [`shell.bin` + bundled command binaries])
      #entry([/config], [initial environment, emulator options, OS version])
      #entry([/device], [`terminal.dev` / `null.dev`: virtual device markers, no device data])
      Files persist here. `..` stops at `/`; host `/tmp` is not mounted. Links and special host files are rejected.
    ])

    #card([Print, inspect & edit], [
      #entry([echo.bin TEXT...], [print; literal `\n` → newline])
      #entry([cat.bin [FILE...]], [print files or stdin])
      #entry([pwd.bin], [current directory])
      #entry([ls.bin [-a] [DIR]], [list; `-a` includes hidden; `d` marks directories])
      #entry([ps.bin], [PID + binary path; includes unreaped zombies])
      #entry([uname.bin], [`PicoOS-` + installed OS version])
      #entry([sed.bin EXPR], [edit stdin → stdout])
      All 18 applications listed. Help: sole `-h` / `--help`, except `echo.bin`; also #box[`cd -h`].
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
      #entry([poweroff.bin], [shut down PicoOS])
      #entry([reboot.bin], [bootloader + kernel restart; emulator stays open])
      #entry([shell.bin], [new shell])
      `DELAY` ≥ 0 counts loop iterations, not milliseconds.
    ], color: coral)

    #card([`sed.bin` expressions], [
      #entry([#raw("'5iTEXT'")], [insert before line 5])
      #entry([#raw("'5cTEXT'")], [replace line 5])
      #entry([#raw("'5aTEXT'")], [append after line 5])
      #entry([#raw("'/word/iTEXT'")], [insert before each matching line])
      #entry([#raw("'s/old/new/'")], [replace first literal match on each line])
      Seekable input via `< FILE` or `|`; reads the whole file into memory. No file operand, regex, or `g` flag.
      #codeblock[#raw("sed.bin '2cNEW' < a.txt > b.txt")]
    ], color: coral)

    #card([`cat.bin`: text & binary files], [
      #codeblock[#raw("cat.bin > notes.txt")]
      Enter writes a line; Backspace / Del edits; Ctrl+D saves pending text and finishes. Feedback uses stderr.
      Terminal output: printable ASCII, newline, CR, tab unchanged; other bytes → `\xHH`. File copies preserve every byte.
    ], color: coral)
  ],
  [
    #card([Redirection], [
      #entry([CMD < FILE], [stdin from file])
      #entry([CMD > FILE], [replace stdout file])
      #entry([CMD >> FILE], [append stdout file])
      #entry([CMD 2> FILE], [replace stderr file])
      #entry([CMD 2>> FILE], [append stderr file])
      After arguments: `<`, then `>` / `>>`, then `2>` / `2>>`; spaces before operators, optional `&` last. External commands and `run` only.
      #codeblock[#raw("cat.bin < a.txt > b.txt 2> err.txt\ncat.bin missing 2>> err.txt")]
      `/device/null.dev` discards output; `/device/terminal.dev` writes to the terminal.
      Opens use slots 0–4 (0–2 are standard streams); 5–7 are reserved for redirection saves. Exhaustion prevents the child from starting.
    ])

    #card([Pipelines & command files], [
      #codeblock[#raw("cat.bin a.txt | sed.bin 's/old/new/'\nshell.bin < commands.txt")]
      One `|`: left finishes before right starts. Whole output uses a temporary file in the current directory. Use finite external commands, without `&`, in a writable directory. Command files: one command per line; EOF exits the child shell.
    ], color: green)

    #card([Jobs & terminal keys], [
      #entry([CMD &], [start background; set `$!`])
      #entry([Ctrl+Z], [`SIGTSTP`; remember PID])
      #entry([fg], [foreground + `SIGCONT`])
      #entry([bg], [background + `SIGCONT`])
      #entry([Ctrl+C], [`SIGINT` foreground job])
      #entry([SIGTTIN], [background terminal read stops])
      One tracked job only; use `fg` for terminal input.
      At the shell prompt, Ctrl+C / Ctrl+Z are ignored. Exiting a shell kills its remaining children.
    ])

    #card([`kill.bin` signals], [
      #signal([0], [probe], [check non-zombie PID])
      #signal([2], [SIGINT], [terminate → 130])
      #signal([9], [SIGKILL], [terminate → 137])
      #signal([18], [SIGCONT], [continue])
      #signal([19], [SIGSTOP], [stop → 147])
      #signal([20], [SIGTSTP], [stop → 148])
      #signal([21], [SIGTTIN], [stop input → 149])
      #codeblock[#raw("kill.bin SIGSTOP $!\nkill.bin 18 $!\nkill.bin $!\nkill.bin 0 $!")]
      Only these signals; names/numbers have no leading `-`. Fixed actions. Arrows show result status.
    ], color: coral)

    #card([Shell & command limits], [
      Wildcards · aliases · `$(...)` · `;` · general escapes · bare `N=V` assignments

      `echo`: no `-n` · `mkdir`: no `-p` · `rm`: no `-r/-f` · `ls`: no sorting, long or recursive mode
    ], color: amber)

  ],
)
