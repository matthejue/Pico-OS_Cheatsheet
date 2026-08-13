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
#set text(font: "Cantarell", size: 7.7pt, fill: ink)
#set par(justify: true, leading: 0.35em, spacing: 1.8pt)
#set list(indent: 6.5pt, body-indent: 2.5pt, spacing: 1pt)
#show raw: set text(font: "Fira Code", size: 6.35pt)
#show strong: set text(fill: teal)

#let mono(body) = box(
  fill: soft,
  stroke: 0.3pt + border,
  radius: 1pt,
  inset: (x: 1.6pt, y: 0.45pt),
  text(font: "Fira Code", size: 6.3pt, fill: rgb("17545c"), body),
)

#let codeblock(body) = block(
  width: 100%,
  fill: navy,
  stroke: 0.45pt + teal.transparentize(45%),
  radius: 1.5pt,
  inset: 2.6pt,
  text(font: "Fira Code", size: 6.3pt, fill: rgb("e7f7f5"), body),
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
      text(size: 8.5pt, weight: "bold", fill: ink, title),
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
  text(font: "Fira Code", size: 6.2pt, fill: rgb("17545c"), body),
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
      #text(size: 14.5pt, weight: "bold", fill: ink)[Cheatsheet]
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
      Commands without `/` are searched in `PATH` (default `./user`). Paths
      containing `/` are used directly.
      #codeblock[#raw("PicoOS> echo.bin hello\nprocess with pid 3 created\nhello")]
      Max line: *79 characters*. `$NAME` = environment variable, `$?` = last
      foreground result, `$!` = latest background PID. Double quotes are
      removed but do not group words.
    ])

    #card([All built-ins], [
      #entry([cd DIR], [change the current directory])
      #entry([export N=V], [set a variable for child programs])
      #entry([load PATH], [create `NEW`; print PID])
      #entry([run PID ARGS], [start loaded process])
      #entry([unload PID], [remove one not yet run])
      #entry([list], [show `PID binary-path`])
      #entry([fg / bg], [continue the latest job])
      #entry([eval CMD], [run another shell command])
      #entry([exit], [end shell; init restarts it])
      #entry([run-shell-tests FILE], [run shell tests])
    ])

    #card([Editing & history], [
      #entry([Enter / Ctrl+M], [submit])
      #entry([Backspace / Delete], [erase char])
      #entry([Ctrl+U / Ctrl+W], [erase line / word])
      #entry([↑ / ↓], [last 8 distinct commands])
      Left/Right are not supported. Programs receive a copy of the shell
      environment. Initial values come from `./config/environment.txt`.
    ], color: green)

    #card([Not supported by the shell], [
      Pipes, `<`, `2>`, wildcards, aliases, `$(...)`, `;`, single quotes, and
      quotes that preserve spaces.
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
      Use `-h` / `--help` where available.
    ])

    #card([Redirection], [
      #entry([CMD > FILE], [create or empty the file; write output there])
      #entry([CMD >> FILE], [create the file or add output at the end])
      #codeblock[#raw("echo.bin first > log.txt\necho.bin next >> log.txt\ncount.bin 0 >> counts.txt &")]
      The file name must be last. Only normal output is redirected; error
      messages stay on the terminal.
    ], color: coral)

    #card([`ls.bin` & files], [
      `d NAME` = directory, `- NAME` = regular file. `.` / `..` and hidden
      names are shown. No sizes, permissions, or sorting.

      Files are stored on the host and accessed through the emulator. FDs
      `0/1/2` = stdin/stdout/stderr; regular files use `3–7`. Child programs
      inherit the standard FDs and current directory.
    ], color: green)

  ],
  [
    #card([Files · `unistd` / `fcntl`], [
      #api[#raw("read(fd,buf,n) · write(fd,buf,n)\nclose(fd) · dup2(old,new)\nlseek(fd,off,SEEK_SET|CUR|END)\nopen(path,flags,...) · creat(path,mode)\nchdir(path) · getcwd(buf,size)\nunlink(path) · rmdir(path) · mkdir(path)")]
      Flags: `O_RDONLY`, `O_WRONLY`, `O_RDWR`, `O_CREAT`, `O_TRUNC`,
      `O_APPEND`. `PATH_MAX=512`. Negative return = error. `read` / `write` may
      handle fewer than `n` cells. FDs `0–2` cannot be closed.
    ])

    #card([Directories · `dirent`], [
      #api[#raw("DIR *opendir(path)\nstruct dirent *readdir(DIR*)\nclosedir(DIR*)\nDT_DIR · DT_REG · DIRENT_NAME_MAX=128")]
      `readdir` returns `NULL` at the end and reuses its entry. `opendir`
      includes `.` and `..`.
    ], color: green)

    #card([Streams · `stdio`], [
      #api[#raw("stdin · stdout · stderr\nfopen(path,mode) · fclose(FILE*)\nfputc(c,f) · fputs(text,f)\nfprintf(f,fmt,...) · printf(fmt,...)\nscanf(fmt,...)")]
      5 extra streams; no buffering. Modes: `r`, `w`, `a`, with optional `+`.
      Formats: `%d`, `%c`, `%s`, `%%`. `scanf("%s")` has no length limit.
    ], color: coral)

    #card([Strings · `string`], [
      #api[#raw("memcpy(dst,src,n) · memset(buf,val,n)\nstrcpy(dst,src) · strcat(dst,src)\nstrcmp(a,b) · strncmp(a,b,n) · strlen(s)")]
      Characters, integers, and pointers use 32-bit cells. Sizes/counts are in
      cells, not host bytes.
    ], color: green)

    #card([Jobs], [
      `CMD &` starts in the background. `fg` continues the latest job in the
      foreground; `bg` continues it in the background. Only one job is kept.
      #codeblock[#raw("count.bin 0 &\necho.bin pid=$!\nfg        # then Ctrl+Z\nbg")]
      Result `0` = success; utilities normally use `1` for errors.
    ])

    #card([Terminal signals], [
      #entry([Ctrl+C], [`SIGTERM` 15; terminate by default])
      #entry([Ctrl+Z], [`SIGTSTP` 20; stop by default])
      Shortcuts target the foreground program. Use emulator view `V` so the
      keys reach PicoOS.
      #entry([0], [check whether the process exists; send nothing])
      #entry([SIGKILL 9], [always terminate; cannot be handled or ignored])
      #entry([SIGTERM 15], [terminate; may be handled or ignored])
      #entry([SIGCHLD 17], [child notice; ignored by default])
      #entry([SIGCONT 18], [continue])
      #entry([SIGTSTP 20], [stop; may be handled or ignored])
      `kill.bin` accepts names or numbers. Signal result = `128 + signal`.
    ], color: coral)

    #card([Processes in programs], [
      #api[#raw("load(path) · run(pid,args,env)\nunload(pid) · list() · getpid()\nwaitpid(pid) · WIFSTOPPED(status) · exit(status)")]
      `run(..., NULL)` copies the environment. `waitpid(pid)` waits for one
      child. Returning from `main` calls `exit`.
    ], color: green)

  ],
  [
    #card([Memory · `stdlib`], [
      #api[#raw("malloc(size) · realloc(ptr,size) · free(ptr)\natoi(text) · exit(status)")]
      `_start`: set up heap/environment → `main(argc,argv)` → `exit`. Fixed
      heap; no virtual memory or memory protection.
    ])

    #card([Environment · `stdlib`], [
      #api[#raw("getenv(name) · setenv(name,value,overwrite)\nunsetenv(name) · putenv(\"N=V\") · clearenv()")]
      Child programs receive a copy. `putenv` copies its text.
      `setenv(..., false)` keeps an existing value.
    ], color: green)

    #card([Signals & parent death], [
      #api[#raw("signal(sig,handler) · kill(pid,sig)\nSIG_DFL · SIG_IGN · SIG_ERR\nprctl(PR_SET_PDEATHSIG, sig)")]
      `SIGKILL` cannot be handled or ignored. Parent-death signal `0` disables
      the setting. `PR_SET_PDEATHSIG` is the only `prctl` option.
    ], color: coral)

    #card([Scheduling & mutexes], [
      #api[#raw("yield()\nmutex_init(m) · mutex_lock(m) · mutex_unlock(m)")]
      Ready programs run round-robin. `yield` gives up the CPU early. Mutexes
      use atomic `TSL` and sleep while locked.
    ])

    #card([Shared memory · `sys/mman`], [
      #api[#raw("shm_open(name,size) · mmap(id)\nshm_unlink(name)")]
      Named shared blocks; size in 32-bit cells. `mmap(id)` returns the shared
      address. Use a mutex for writes. Not file-backed.
    ], color: green)

    // the Makefile targets are not so important to belong on this cheathsset. Please fill the cheatsheet with something more important
    #card([Process states], [
      #entry([READY], [can be scheduled])
      #entry([RUNNING], [currently executing])
      #entry([BLOCKED], [sleeping on a wait queue])
      #entry([STOPPED], [paused by `SIGTSTP`])
      #entry([ZOMBIE], [finished; parent can collect status])
      Timer interrupts and `yield()` move a running process back to `READY`.
      `wakeup()` moves a waiter to `READY`; `SIGCONT` resumes a stopped process.
    ], color: teal)

    #card([Compile & size a program], [
      Common compiler options: `-C` startup, `-O1`, `-s`, `-g`, `-o`; debug:
      `-i -w -v`; memory header: `-k sram|eprom`; all options: `-h`.
      #codeblock[#raw("picoc_compiler --heap-size 2000 \\\n  --stack-size 1000 -o app.reti app.picoc\nreti_emulator -a app.reti")]
      `-a`: read `.sections` → write `.bin`. Edit `.sections` after compiling,
      before assembling. For `N` stack cells:
      `stack_start = heap_start + heap_size + N` (stack grows down).

      Emulator terminals: `Esc` leaves `(v)` terminal view; `Ctrl+]` leaves
      `(V)` raw terminal.
    ], color: coral)

    #card([Blocking & wait queues], [
      #api[#raw("struct wait_queue queue\nsleep(&queue) · wakeup(&queue)")]
      `sleep` blocks the current process without a timeout. `wakeup` makes the
      first waiter ready. A process can wait on only one queue. Mutexes use the
      same FIFO waiting mechanism.
    ], color: green)
  ],
)
