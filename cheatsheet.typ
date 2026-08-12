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
      columns: (1fr, auto),
      [PicoOS · shell, applications and programming functions],
      [quick reference],
    )
  ],
)
#set text(font: "Cantarell", size: 7pt, fill: ink)
#set par(justify: true, leading: 0.35em, spacing: 1.8pt)
#set list(indent: 6.5pt, body-indent: 2.5pt, spacing: 1pt)
#show raw: set text(font: "Fira Code", size: 6.15pt)
#show strong: set text(fill: teal)

#let mono(body) = box(
  fill: soft,
  stroke: 0.3pt + border,
  radius: 1pt,
  inset: (x: 1.6pt, y: 0.45pt),
  text(font: "Fira Code", size: 6.05pt, fill: rgb("17545c"), body),
)

#let codeblock(body) = block(
  width: 100%,
  fill: navy,
  stroke: 0.45pt + teal.transparentize(45%),
  radius: 1.5pt,
  inset: 2.6pt,
  text(font: "Fira Code", size: 6.05pt, fill: rgb("e7f7f5"), body),
)

#let card(title, body, color: teal) = block(
  width: 100%,
  fill: panel,
  stroke: 0.45pt + border,
  radius: 2pt,
  inset: (left: 3.2pt, right: 3.2pt, top: 2.4pt, bottom: 3pt),
  breakable: true,
  [
    #grid(
      columns: (1.8pt, 1fr),
      gutter: 3pt,
      rect(width: 1.8pt, height: 7pt, radius: 0.8pt, fill: color),
      text(size: 8.2pt, weight: "bold", fill: ink, title),
    )
    #v(1.2pt)
    #body
  ],
)

#let entry(left, right) = grid(
  columns: (auto, 1fr),
  gutter: 2.2pt,
  align: top,
  mono(left),
  right,
)

#let api(body) = block(
  width: 100%,
  fill: soft,
  stroke: 0.35pt + border,
  radius: 1.3pt,
  inset: 2.4pt,
  text(font: "Fira Code", size: 5.9pt, fill: rgb("17545c"), body),
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
      #text(size: 14.5pt, weight: "bold", fill: ink)[One-page cheatsheet]
    ],
    text(size: 5.3pt, fill: muted)[Shell · files · jobs · signals · library functions · build],
  )
]
#v(3.5pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 4mm,
  align: top,
  [
    #card([Using the shell], [
      For names without `/`, the shell searches the directories in `PATH`
      (separated by `:`; default `./user`). A path containing `/` is used as
      written. The shell loads the program, starts it, and prints its PID.
      #codeblock[#raw("PicoOS> echo.bin hello\nprocess with pid 3 created\nhello")]
      Max line: *79 characters*. Spaces and tabs split arguments. `$NAME`, `$?`
      (last foreground result), and `$!` (latest background PID) are replaced
      before the program starts. Double quotes are removed but do not keep
      spaces inside one argument. Names and paths are case-sensitive.
    ])

    #card([All built-ins], [
      #entry([cd DIR], [change the current directory])
      #entry([export N=V], [set a variable for child programs])
      #entry([load PATH], [create `NEW`; print PID])
      #entry([run PID ARGS], [start loaded process])
      #entry([unload PID], [remove one not yet run])
      #entry([list], [print `PID binary-path` for all processes])
      #entry([fg / bg], [continue the latest job])
      #entry([eval CMD], [run another shell command])
      #entry([exit], [end shell; init restarts it])
      #entry([run-shell-tests FILE], [run a shell-test file])
    ])

    #card([Editing, history, environment], [
      #entry([Enter / Ctrl+M], [submit])
      #entry([Backspace / Delete], [erase char])
      #entry([Ctrl+U / Ctrl+W], [erase line / word])
      #entry([↑ / ↓], [last 8 distinct commands])
      Left/Right do not move the cursor; other special key sequences do
      nothing. Programs receive a copy of the shell environment. Init reads
      `./config/environment.txt`. `N=V` alone is treated as a command; there is
      no shell `unset`.
    ], color: green)

    #card([What the shell cannot do], [
      There are no pipes, input redirection (`<`), error redirection (`2>`),
      wildcards, aliases, `$(...)`, several commands separated by `;`, single
      quotes, or quotes that preserve spaces. `PICOOS_LOADING_BAR=true` shows
      loading bars for supported file and program transfers.
    ], color: amber)

    #card([User applications], [
      #entry([echo.bin TEXT...], [print args; literal `\n` → newline])
      #entry([cat.bin FILE...], [print files; does not read keyboard input])
      #entry([count.bin [DELAY]], [count forever; default 25000])
      #entry([ls.bin [DIR]], [list dir; default `.`])
      #entry([pwd.bin], [print cwd])
      #entry([mkdir.bin DIR...], [create directories])
      #entry([rm.bin FILE...], [remove files])
      #entry([rmdir.bin DIR...], [remove empty dirs])
      #entry([kill.bin [SIG] PID], [default `SIGTERM`])
      #entry([poweroff.bin], [halt PicoOS/emulator])
      Utilities support `-h` / `--help` where applicable. `cat`, `mkdir`, `rm`,
      and `rmdir` keep trying the remaining paths after an error.
    ])

    #card([Redirection], [
      #entry([CMD > FILE], [create or empty the file; write output there])
      #entry([CMD >> FILE], [create the file or add output at the end])
      #codeblock[#raw("echo.bin first > log.txt\necho.bin next >> log.txt\ncount.bin 0 >> counts.txt &")]
      Put a space before `>` / `>>`, and put the file name last. This works with
      programs, `run`, and `&`. Error messages stay on the terminal.
    ], color: coral)

    #card([`ls.bin` & host files], [
      Output is `d NAME` for a directory or `- NAME` for a regular file. It
      includes `.`, `..`, and hidden names; no size, owner, permissions, sort,
      or flags. Order is the host directory order.

      PicoOS has no disk of its own. It asks the emulator through UART to read
      and write files on the host computer. File descriptors `0/1/2` are
      stdin/stdout/stderr; regular files use `3–7`. Child programs inherit the
      three standard descriptors and the current directory. PicoOS understands
      `.`, `..`, and repeated slashes. File writes add at the end; `>` empties
      the file first. `lseek` changes where the next read starts. `PATH=./user`
      still points to the original user directory after `cd`.
    ], color: green)

  ],
  [
    #card([Files and directories in programs], [
      #api[#raw("read(fd,buf,n) · write(fd,buf,n)\nclose(fd) · dup2(old,new)\nlseek(fd,off,SEEK_SET|CUR|END)\nopen(path,flags,...) · creat(path,mode)\nchdir(path) · getcwd(buf,size)\nunlink(path) · rmdir(path) · mkdir(path)")]
      Flags: `O_RDONLY`, `O_WRONLY`, `O_RDWR`, `O_CREAT`, `O_TRUNC`,
      `O_APPEND`; `O_ACCMODE` selects the read/write part. PicoOS ignores Unix
      permission modes. `PATH_MAX=512`. A negative return means an error;
      `read` and `write` may handle fewer than `n` cells. Descriptors `0–2`
      cannot be closed. Include functions with
      `library/<name>/<name>.header`; PicoOS implements only part of POSIX.
    ])

    #card([Directories · `dirent`], [
      #api[#raw("DIR *opendir(path)\nstruct dirent *readdir(DIR*)\nclosedir(DIR*)\nDT_DIR · DT_REG · DIRENT_NAME_MAX=128")]
      `readdir` returns `NULL` at the end and reuses the same entry each time.
      Copy a name if it is needed after the next call. `opendir` can hold up to
      512 cells and includes `.` and `..`.
    ], color: green)

    #card([Streams · `stdio`], [
      #api[#raw("stdin · stdout · stderr\nfopen(path,mode) · fclose(FILE*)\nfputc(c,f) · fputs(text,f)\nfprintf(f,fmt,...) · printf(fmt,...)\nscanf(fmt,...)")]
      Five extra streams can be open. Output is written immediately. Modes are
      `r`, `w`, `a`, and the same modes with `+`. `printf`/`fprintf` support
      `%d %c %s %%`; `scanf` supports the same. `%s` has no length limit, so
      its destination buffer must be large enough.
    ], color: coral)

    #card([Strings · `string`], [
      #api[#raw("memcpy(dst,src,n) · memset(buf,val,n)\nstrcpy(dst,src) · strcat(dst,src)\nstrcmp(a,b) · strncmp(a,b,n) · strlen(s)")]
      RETI/PicoC stores characters, integers, and pointers in 32-bit cells.
      Sizes and counts therefore refer to cells, not bytes on the host computer.
    ], color: green)

    #card([Jobs & process actions], [
      A trailing `&` starts a program without waiting. `fg` continues the
      latest job in the foreground and waits for it; `bg` continues it in the
      background. The shell remembers only one background or stopped job—there
      is no jobs list or `%job` syntax.
      #codeblock[#raw("count.bin 0 &\necho.bin pid=$!\nfg        # then Ctrl+Z\nbg")]
      `load` creates a process, `run` starts it, and `unload` removes it only if
      it has not run. `list` shows every PID and program path. Result `0` means
      success; utilities normally use `1` for bad input or another error.
    ])

    #card([Terminal signals], [
      #entry([Ctrl+C], [`SIGTERM` 15; terminate by default])
      #entry([Ctrl+Z], [`SIGTSTP` 20; stop by default])
      These keys send a signal to the foreground program. In the emulator
      debugger, use capital `V` so the keys reach PicoOS.
      #entry([0], [check whether the process exists; send nothing])
      #entry([SIGKILL 9], [always terminate; cannot be handled or ignored])
      #entry([SIGTERM 15], [terminate; may be handled or ignored])
      #entry([SIGCHLD 17], [child notice; ignored by default])
      #entry([SIGCONT 18], [continue])
      #entry([SIGTSTP 20], [stop; may be handled or ignored])
      `kill.bin` accepts these names or numbers. Signal status is `128 + sig`.
    ], color: coral)

    #card([Processes in programs], [
      #api[#raw("load(path) · run(pid,args,env)\nunload(pid) · list() · getpid()\nwaitpid(pid) · WIFSTOPPED(status) · exit(status)")]
      With `run(..., NULL)`, the child gets a copy of the current environment.
      `waitpid(pid)` waits for that child and returns its result. There is no
      options argument and no `waitpid(-1)`. Returning from `main` calls `exit`.
    ], color: green)

  ],
  [
    #card([Memory and program start], [
      #api[#raw("malloc(size) · realloc(ptr,size) · free(ptr)\natoi(text) · exit(status)")]
      Before `main`, `_start` sets up the heap and environment. It then calls
      `main(argc,argv)` and passes the return value to `exit`. The heap size is
      fixed. PicoOS has no virtual memory or memory protection.
    ])

    #card([Environment · `stdlib`], [
      #api[#raw("getenv(name) · setenv(name,value,overwrite)\nunsetenv(name) · putenv(\"N=V\") · clearenv()")]
      Variables are stored in the process heap, and `putenv` copies its text.
      Child programs receive a copy. Do not keep a pointer returned by `getenv`
      after changing the environment. `setenv(..., false)` keeps an existing
      value.
    ], color: green)

    #card([Signals & parent death], [
      #api[#raw("signal(sig,handler) · kill(pid,sig)\nSIG_DFL · SIG_IGN · SIG_ERR\nprctl(PR_SET_PDEATHSIG, sig)")]
      A program cannot handle or ignore `SIGKILL`; it can do so for the other
      listed signals. Only one signal handler can run at a time, so keep it
      short. Parent-death signal `0` disables the setting. This is the only
      supported `prctl` option.
    ], color: coral)

    #card([Scheduling & mutexes], [
      #api[#raw("yield()\nmutex_init(m) · mutex_lock(m) · mutex_unlock(m)")]
      The timer switches between ready programs in turn. `yield` lets another
      program run early. A mutex waits instead of repeatedly checking the lock;
      it uses RETI's atomic `TSL` instruction and wakes waiters in order. PicoOS
      does not switch processes while kernel code is running.
    ])

    #card([Shared memory · `sys/mman`], [
      #api[#raw("shm_open(name,size) · mmap(id)\nshm_unlink(name)")]
      `shm_open` creates or opens a named block; its size is in 32-bit cells.
      `mmap` returns the shared address. Use a mutex when several programs write
      it. This `mmap` is not connected to files and accepts only the shared ID.
    ], color: green)

    #card([Project build], [
      #entry([make help], [show targets])
      #entry([make user], [build user binaries])
      #entry([make firmware], [build bootloader and kernel files])
      #entry([make release-tree], [build everything under `binary/`])
      #entry([make verify-release-tree], [check that all release files exist])
      #entry([make bootload], [build + boot in debugger])
      #entry([make bootload-debug], [rebuild `-g` + boot])
      Layers: `make eprom`, `kernel`, `isrs`, `system`.
    ], color: teal)

    #card([Compile and size a program], [
      Build uses `picoc_compiler --show-input-files`, `-C` startup, `-O1`, `-s`,
      `-g`, `-o`; debug also uses `-i -w -v`. `-k sram|eprom` writes the memory
      constants header. Prefer Make; use `-h` for the full option list.
      #codeblock[#raw("picoc_compiler --heap-size 2000 \\\n  --stack-size 1000 -o app.reti app.picoc\nreti_emulator -a app.reti")]
      `-a` reads `app.sections`, adds the five layout numbers PicoOS needs,
      writes `app.bin`, and exits. You may edit `.sections` after compiling and
      before assembling. For `N` stack cells, use
      `stack_start = heap_start + heap_size + N`. The stack grows downward and
      must not overlap the heap.
    ], color: coral)

    #card([Use the emulator debugger], [
      Make uses emulator `-e` EPROM, `-n 4` IVT entries, `-r` SRAM cells, `-S`
      sections, `-D` debuginfo, `-d` debugger, `-c` comments, `-O` first RTI.
      Press `c` to run. Capital `V` opens the raw UART terminal; `Ctrl+]`
      returns. This mode sends control keys and arrows to PicoOS. `E` pauses,
      `n` runs one instruction, `r` restarts, lowercase `v` opens the normal
      UART view (Escape returns), and `q` closes a menu or quits.
    ], color: green)
  ],
)
