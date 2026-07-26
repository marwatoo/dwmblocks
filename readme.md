<div align="center">

# marwatoo/dwmblocks

**A from-scratch rewrite of dwmblocks — a modular status feed generator for dwm**

*XCB-based · X-macro block definitions · Signal-driven updates*

![C](https://img.shields.io/badge/language-C99-blue?style=flat-square)
![License](https://img.shields.io/badge/license-GPL--2.0-green?style=flat-square)
![dwmblocks](https://img.shields.io/badge/based%20on-dwmblocks-black?style=flat-square)

![dwmblocks bar](bar.png)

</div>

---

## About

This isn't a fork of Luke Smith's or torrinfail's dwmblocks with a modified `blocks.h` — the source itself (`src/`, `include/`) has been rewritten from scratch as a small, self-contained C99 project. It compiles against **XCB** (`xcb-atom`) instead of Xlib, keeps the codebase clang-formatted/linted (`.clang-format`, `.clang-tidy`, `.clangd` all ship in the repo), and defines blocks via a single X-macro list in `config.h` rather than a static array.

Like [marwatoo/slstatus](https://github.com/marwatoo/slstatus), this feeds the status area of [marwatoo/dwm](https://github.com/marwatoo/dwm), and the two are swapped depending on need — dwmblocks when independent per-segment update intervals and signal-triggered refreshes matter more than slstatus's simplicity.

## Table of Contents

- [Configuration Highlights](#configuration-highlights)
- [Active Blocks](#active-blocks)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running dwmblocks](#running-dwmblocks)
- [Updating Blocks on Demand](#updating-blocks-on-demand)
- [Credits](#credits)

## Configuration Highlights

Verified directly against `config.h` and the `Makefile`:

| Feature | Description |
|---|---|
| **XCB backend** | Links against `xcb-atom` via `pkg-config` rather than Xlib, making it a lighter dependency than the traditional Xlib-based dwmblocks implementations. |
| **X-macro block list** | `#define BLOCKS(X) X(icon, cmd, interval, signal) ...` generates the block table at compile time — adding a block means adding one line, no struct boilerplate. |
| **Configurable delimiter** | `DELIMITER` (default: a single space) separates block output; `LEADING_DELIMITER` / `TRAILING_DELIMITER` toggle whether it's applied at the very start/end of the bar. |
| **Output length cap** | `MAX_BLOCK_OUTPUT_LENGTH` (45 Unicode chars) bounds how much a single block can print, protecting the bar from a runaway script. |
| **Clickable blocks toggle** | `CLICKABLE_BLOCKS` is present but currently disabled (`0`) in this config — the plumbing for click-to-run-command exists but isn't active. |
| **Modular source layout** | `src/*.c` compile into `build/*.o` via a wildcard Makefile rule, with headers in `include/` — a cleaner separation than the single-file `dwmblocks.c` most builds use. |
| **Code quality tooling** | `.clang-format`, `.clang-tidy`, and `.clangd` are checked into the repo, so the build is meant to be linted/formatted consistently rather than one-off tinkered with. |

## Active Blocks

In order, as defined in `config.h`'s `BLOCKS(X)` macro:

| Icon | Script | Interval | Signal |
|---|---|---|---|
|  | `~/.config/dwm/volume.sh` | 1s | 1 |
|  | `~/.config/dwm/brightness.sh` | 1s | 2 |
|  | `~/.config/dwm/keyboard.sh` | 1s | 3 |
|  | `~/.config/dwm/clock.sh` | 30s | 4 |
|  | `~/.config/dwm/battery.sh` | 1s | 5 |

A sixth block (`kde.sh`, signal 6) exists in the config but is currently commented out.

## Requirements

- `libxcb` + `xcb-atom` (queried via `pkg-config`)
- A C99 compiler (`make` uses `.POSIX:` rules)

## Installation

```bash
git clone https://github.com/marwatoo/dwmblocks.git
cd dwmblocks
sudo make clean install
```

This builds `build/dwmblocks` and installs it to `$PREFIX/bin` (`/usr/local/bin` by default). Edit `config.h` before building to change blocks, delimiters, or output limits.

## Running dwmblocks

Add it to your `.xinitrc` (or dwm's `autostart`) before `exec dwm`:

```bash
dwmblocks &
exec dwm
```

## Updating Blocks on Demand

Each block has its own **signal number** (see the table above). Instead of waiting for a block's polling interval, trigger an immediate refresh by sending its signal:

```bash
pkill -RTMIN+<signal> dwmblocks
```

For example, to refresh the volume block (signal 1) right after a volume keypress:

```bash
pkill -RTMIN+1 dwmblocks
```

## Credits

- Inspired by [torrinfail/dwmblocks](https://github.com/torrinfail/dwmblocks), the original modular status generator for dwm
- Paired with [marwatoo/dwm](https://github.com/marwatoo/dwm) and [marwatoo/slstatus](https://github.com/marwatoo/slstatus)

---

<div align="center">

*See [LICENSE](LICENSE) for copyright and license details (GPL-2.0).*

</div>