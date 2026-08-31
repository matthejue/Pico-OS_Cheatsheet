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
    #set text(font: "Cantarell", size: 4.7pt, fill: muted)
    #line(length: 100%, stroke: 0.4pt + border)
    #v(1.2pt)
    #grid(
      columns: (1fr, auto, auto),
      gutter: 5pt,
      [PicoOS · interactive shell and bundled user applications],
      [runtime quick reference],
      [#release_version],
    )
  ],
)
#set text(font: "Cantarell", size: 7.8pt, fill: ink)
#set par(justify: true, leading: 0.37em, spacing: 1.9pt)
#set list(indent: 6.5pt, body-indent: 2.5pt, spacing: 0.8pt)
#show raw: set text(font: "Fira Code", size: 6.4pt)
#show strong: set text(fill: teal)

#let mono(body) = box(
  fill: soft,
  stroke: 0.3pt + border,
  radius: 1pt,
  inset: (x: 1.5pt, y: 0.4pt),
  text(font: "Fira Code", size: 6.3pt, fill: rgb("17545c"), body),
)

#let codeblock(body) = block(
  width: 100%,
  fill: navy,
  stroke: 0.45pt + teal.transparentize(45%),
  radius: 1.5pt,
  inset: 2.5pt,
  text(font: "Fira Code", size: 6.3pt, fill: rgb("e7f7f5"), body),
)

#let card(title, body, color: teal) = block(
  width: 100%,
  fill: panel,
  stroke: 0.45pt + border,
  radius: 2pt,
  inset: (left: 3.2pt, right: 3.2pt, top: 3pt, bottom: 4pt),
  breakable: true,
  [
    #grid(
      columns: (1.8pt, 1fr),
      gutter: 3pt,
      rect(width: 1.8pt, height: 7pt, radius: 0.8pt, fill: color),
      text(size: 8.8pt, weight: "bold", fill: ink, title),
    )
    #v(1.1pt)
    #body
  ],
)

#let entry(left, right) = grid(
  columns: (auto, 1fr),
  gutter: 2.1pt,
  align: top,
  mono(left),
  right,
)

#let signal(number, name, effect) = grid(
  columns: (12pt, 45pt, 1fr),
  gutter: 2pt,
  align: top,
  text(font: "Fira Code", size: 6.3pt, fill: coral, number),
  text(font: "Fira Code", size: 6.3pt, fill: rgb("17545c"), name),
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
    text(size: 5.3pt, fill: muted)[Start · shell · files · jobs · signals · every bundled command],
  )
]
#v(3.5pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 4mm,
  align: top,
  [
    #card([Start the release], [
      #entry([Linux/macOS], [`./download-tools.sh` → `./start-picoos.sh`])
      #entry([Windows], [`.\download-tools.ps1` → `.\start-picoos.ps1`])
      #entry([Android], [use the Linux scripts in Termux])
      With the Debug TUI: press `c` to boot, `V` for the raw PicoOS terminal,
      and `Ctrl+]` to return. `--notui` / PowerShell `-NoTui` starts directly
      in the terminal.
    ])

    #card([Release archive map], [
      #entry([boot/], [EPROM reset/bootloader image])
      #entry([kernel/], [`kernel.bin` plus layout/debug metadata])
      #entry([system/], [`init.bin`: PID 1, config + shell restart policy])
      #entry([user/], [shell and 16 commands; default `PATH=./user`])
      #entry([config/], [startup environment + emulator options])
      #entry([device/], [`terminal.dev` is only a visible marker])
      Root scripts download tools and launch the runtime. The real terminal is
      the virtual path `/device/terminal`.
    ], color: green)

    #card([Shell grammar], [
      Names without `/` are searched in colon-separated `PATH`; paths with
      `/` load directly. Relative `PATH` entries keep working after `cd`.
      #codeblock[#raw("echo.bin 'hello PicoOS'\n./user/pwd.bin\necho.bin $PATH status=$? pid=$!")]
      Single/double quotes group arguments and are removed. `$NAME` expands an
      environment variable; `$?` is the latest foreground status and `$!` the
      latest background/stopped PID. `echo.bin` alone turns literal `\n` into
      a newline.
    ])

    #card([Editing & history], [
      #entry([Enter], [run the line; max 79 characters])
      #entry([Backspace / Del], [erase one character])
      #entry([Ctrl+U / Ctrl+W], [erase line / previous word])
      #entry([↑ / ↓], [navigate 8 recent commands + draft])
      Left/right are consumed but do not move the cursor. Tab is inserted as
      input when space remains.
    ], color: green)

    #card([All shell built-ins], [
      #entry([cd DIR], [change this shell's working directory])
      #entry([export N=V], [set a session environment variable])
      #entry([eval COMMAND], [evaluate again in the same shell])
      #entry([load PATH], [create a `NEW` process; print its PID])
      #entry([run PID [ARGS]], [start a loaded PID; accepts `&`, `>`, `>>`])
      #entry([unload PID], [remove a selected process])
      #entry([fg / bg], [continue the one tracked job])
      #entry([exit], [end session; init launches a fresh shell])
      #entry([run-shell-tests FILE], [internal scripted-test manifest runner])
    ])

    #card([Shell limits], [
      No pipes, `<`, stderr redirection, wildcards, aliases, `$(...)`, `;`, or
      general backslash escaping. Exactly one final output redirect and one
      trailing background operator are recognized.
    ], color: amber)

    #card([Quick workflow], [
      #codeblock[#raw("pwd.bin\nls.bin -a\nmkdir.bin demo\necho.bin 'hello\\nPicoOS' > demo/a.txt\ncat.bin demo/a.txt\ncp.bin demo/a.txt demo/b.txt\nps.bin\nrm.bin demo/a.txt demo/b.txt\nrmdir.bin demo\npoweroff.bin")]
    ], color: green)
  ],
  [
    #card([Application help], [
      A sole `-h` or `--help` prints usage for every bundled application
      *except `echo.bin`*, which prints it as ordinary text. The complete
      argument forms are listed below.
    ], color: amber)

    #card([Print, inspect & edit], [
      #entry([echo.bin TEXT...], [print words; supports literal `\n`, not `-n`])
      #entry([cat.bin FILE...], [print each file; never reads stdin])
      #entry([pwd.bin], [print the current directory])
      #entry([ls.bin [-a] [DIR]], [list `.` by default; `-a` shows dot names])
      #entry([ps.bin], [print every process as PID + binary path])
      #entry([sed.bin EXPR FILE], [write the transformed contents to stdout])
      `ls.bin` prefixes directories with `d` and files with `-`; order is the
      host order. It has no long, sort, or recursive mode.
    ], color: green)

    #card([`sed.bin` expressions], [
      #codeblock[#raw("sed.bin '5iNEW' file.txt    # insert before 5\nsed.bin '5cNEW' file.txt    # change 5\nsed.bin '5aNEW' file.txt    # append after 5\nsed.bin '/word/iNEW' file.txt # before matches")]
      Only these four forms exist. The pattern is a simple substring; the full
      file is loaded into memory. Redirect to replace indirectly:
      #codeblock[#raw("sed.bin '2cNEW' a.txt > b.txt\nmv.bin b.txt a.txt")]
    ], color: coral)

    #card([Create, copy, move & remove], [
      #entry([touch.bin FILE...], [create or update timestamps; keep contents])
      #entry([cp.bin SRC DST], [copy one regular file])
      #entry([mv.bin SRC DST], [move/rename one file or directory])
      #entry([mkdir.bin DIR...], [create each directory; no `-p`])
      #entry([rm.bin FILE...], [remove files; no `-f` / `-r`])
      #entry([rmdir.bin DIR...], [remove empty directories only])
      Multi-path commands continue after an individual error and still return
      failure. `cp` and `mv` accept exactly two paths and no options.
    ], color: green)

    #card([Processes & power], [
      #entry([count.bin [DELAY]], [count forever; default loop delay `25000`])
      #entry([kill.bin [SIG] PID], [default `SIGKILL`; name or number])
      #entry([poweroff.bin], [halt PicoOS / emulator execution])
      #entry([reboot.bin], [restart bootloader, kernel, init, and shell])
      #entry([shell.bin], [start another shell; accepts no arguments])
      `DELAY` is a busy-loop count, not milliseconds; `count.bin` yields after
      every printed value.
    ], color: coral)

    #card([Output redirection], [
      #entry([CMD > FILE], [create/empty, then write stdout])
      #entry([CMD >> FILE], [create or append stdout])
      #codeblock[#raw("echo.bin first > notes.txt\necho.bin next >> notes.txt\ncount.bin 0 > counts.txt &")]
      The path must be last (before optional `&`). Diagnostics use stderr and
      remain visible. There is no input or stderr redirection.
    ], color: coral)

    #card([Files are host-backed], [
      PicoOS has no on-device disk. File and directory operations are forwarded
      over UART to the host tree from which the emulator was launched. Relative
      operands use the process working directory; `cd` changes PicoOS path state,
      not the emulator process's own directory.
    ], color: amber)
  ],
  [
    #card([Foreground & background jobs], [
      #entry([COMMAND &], [start without waiting; set `$!`])
      #entry([Ctrl+Z], [send `SIGTSTP`; remember stopped PID])
      #entry([fg], [give it terminal input, `SIGCONT`, then wait])
      #entry([bg], [`SIGCONT` without waiting/input ownership])
      #entry([Ctrl+C], [send `SIGINT` to the foreground process])
      #codeblock[#raw("count.bin 0 &\necho.bin background=$!\nfg                 # Ctrl+Z while running\nbg")]
      Only the most recent background/stopped PID is tracked—there is no jobs
      list. A background terminal read stops with `SIGTTIN`; use `fg` to resume
      it with input ownership.
    ])

    #card([`kill.bin`: every signal], [
      #signal([0], [probe], [PID exists; send nothing])
      #signal([2], [SIGINT], [terminate → status 130])
      #signal([9], [SIGKILL], [terminate → status 137])
      #signal([18], [SIGCONT], [resume stopped process])
      #signal([19], [SIGSTOP], [stop → status 147])
      #signal([20], [SIGTSTP], [stop → status 148])
      #signal([21], [SIGTTIN], [stop terminal reader → status 149])
      #codeblock[#raw("kill.bin 42              # SIGKILL\nkill.bin SIGTSTP 42\nkill.bin 18 42          # SIGCONT\nkill.bin 0 42           # existence check")]
      Names have no leading `-`. Only 0 and the six listed numbers are valid.
      Actions are fixed; PicoOS cannot catch or ignore signals.
    ], color: coral)

    #card([Statuses & process messages], [
      Every external launch prints `process with pid N created`. Foreground
      completion sets `$?`; a background launch leaves `$?` unchanged and sets
      `$!`. Normal success is `0`, usage/operation failure usually `1`.
      Signal results use the statuses shown above. `ps.bin` shows live PIDs.
    ], color: green)

    #card([Environment], [
      #entry([export N=V], [set/replace in this shell and future children])
      #entry([`$N`], [expand a stored value; an unknown name becomes empty])
      Startup values are `NAME=value` lines in `config/environment.txt`
      (under 256 cells total), normally `PATH=./user`.

      There is *no `unset` built-in*. `export N=` leaves `N` present but empty.
      Use `exit` to let init start a fresh shell and reset session-only exports,
      or edit `config/environment.txt` before boot for a persistent default.
    ], color: green)

    #card([Loading bar], [
      Presence of `PICOOS_LOADING_BAR` enables progress for program loading and
      larger file reads:
      #codeblock[#raw("export PICOOS_LOADING_BAR=true")]
      The value is irrelevant—even empty enables it. The current build has
      `loading_bar_enabled=true`, so init sets it for every shell. With no
      `unset`, it cannot be disabled interactively. Source builds can toggle
      `config/config.header`; when off, export it or add it to
      `config/environment.txt` to enable bars. `cat`, `cp`, and `sed` suppress
      it in their own process to keep output clean.
    ], color: amber)

    #card([DMA loading], [
      DMA accelerates kernel, init, and later program-image copies. Scheduled
      program loads sleep for completion so other ready processes can run.
      #entry([Release], [`./start-picoos.sh --dma` / `-M`])
      #entry([PowerShell], [`.\start-picoos.ps1 -Dma`])
      #entry([Source tree], [`make bootload-dma`])
      #entry([No TUI], [`make bootload-notui DMA=1`])
      *DMA is not a PicoOS environment variable.* Without these launcher/build
      switches, PicoOS automatically uses its UART polling/chunked fallback.
    ], color: teal)

  ],
)
