<div align="center">

# marwatoo/dwmblocks

**A personalized build of [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) — an asynchronous, modular status feed generator for dwm**

*Async block execution · XCB-based · X-macro block definitions · Signal-driven updates*

![C](https://img.shields.io/badge/language-C99-blue?style=flat-square)
![License](https://img.shields.io/badge/license-GPL--2.0-green?style=flat-square)
![dwmblocks-async](https://img.shields.io/badge/based%20on-dwmblocks--async-black?style=flat-square)

![dwmblocks bar](bar.png)

</div>

---

## About

This is a personalized build of **[UtkarshVerma/dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async)** — not a from-scratch project, and not the classic torrinfail/Luke Smith single-file `dwmblocks.c`. dwmblocks-async is a ground-up reimplementation that executes every block **asynchronously** (in parallel) rather than sequentially, so a slow block (e.g. a network check) never freezes the rest of the bar the way it can in vanilla dwmblocks. It compiles against **XCB** instead of Xlib, organizes source into `src/`/`include/`, and ships `.clang-format`/`.clang-tidy`/`.clangd` for consistent tooling — all inherited directly from upstream.

The only layer that's personal to this build is `config.h`: the specific blocks defined, their scripts, intervals, and signals, plus `CLICKABLE_BLOCKS` toggled off.

Like [marwatoo/slstatus](https://github.com/marwatoo/slstatus), this feeds the status area of [marwatoo/dwm](https://github.com/marwatoo/dwm), and the two are swapped depending on need — dwmblocks-async when independent per-segment update intervals and signal-triggered refreshes matter more than slstatus's simplicity.

## Table of Contents

- [Configuration Highlights](#configuration-highlights)
- [What's Inherited vs. Customized](#whats-inherited-vs-customized)
- [Active Blocks](#active-blocks)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running dwmblocks](#running-dwmblocks)
- [Updating Blocks on Demand](#updating-blocks-on-demand)
- [Credits](#credits)

## Configuration Highlights

Verified directly against `config.h`, the `Makefile`, and upstream dwmblocks-async:

| Feature | Description | Source |
|---|---|---|
| **Asynchronous block execution** | Every block's command runs concurrently rather than one-after-another, so a slow-running script (network lookups, disk scans) can't stall or flicker the rest of the bar. This is the core feature the project is named for. | Inherited from upstream |
| **XCB backend** | Links against `xcb-atom` via `pkg-config` rather than Xlib, a lighter dependency than the classic Xlib-based dwmblocks implementations. | Inherited from upstream |
| **X-macro block list** | `#define BLOCKS(X) X(icon, cmd, interval, signal) ...` generates the block table at compile time — adding a block means adding one line, no struct boilerplate. | Inherited from upstream |
| **Per-block signal updates** | Each block has its own signal number; sending it triggers an immediate refresh independent of that block's polling interval (or `0` to disable polling entirely and rely purely on signals). | Inherited from upstream |
| **Configurable delimiter** | `DELIMITER` separates block output; `LEADING_DELIMITER` / `TRAILING_DELIMITER` toggle whether it's applied at the very start/end of the bar. | Inherited from upstream |
| **Output length cap** | `MAX_BLOCK_OUTPUT_LENGTH` (45 Unicode chars here) bounds how much a single block can print, protecting the bar from a runaway script. | Inherited from upstream |
| **Clickable blocks — disabled** | Upstream defaults `CLICKABLE_BLOCKS` to `1` (click-to-run-command via `$BLOCK_BUTTON`, requires dwm's `statuscmd` patch). **This build sets it to `0`** — the feature is turned off. | **Customized in this build** |
| **The five active blocks + their scripts, intervals, and signals** | See the table below. | **Customized in this build** |

## What's Inherited vs. Customized

- **Inherited from [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async):** the entire `src/`/`include/` codebase, async execution model, XCB usage, X-macro config system, and clang tooling. No source-level changes were needed for this build.
- **Customized here:** only `config.h` — specifically the five blocks listed below, and disabling `CLICKABLE_BLOCKS`.

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
- *(Only if re-enabling `CLICKABLE_BLOCKS`)* dwm patched with [statuscmd](https://dwm.suckless.org/patches/statuscmd/) — not required as currently configured, since clickable blocks are disabled.

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

- [UtkarshVerma/dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) — the actual upstream this build is based on
- Which itself credits [Luke Smith's build of dwmblocks](https://github.com/LukeSmithxyz/dwmblocks) and [Daniel Bylinka's statuscmd patch](https://dwm.suckless.org/patches/statuscmd/)
- Paired with [marwatoo/dwm](https://github.com/marwatoo/dwm) and [marwatoo/slstatus](https://github.com/marwatoo/slstatus)

---

<div align="center">

*See [LICENSE](LICENSE) for copyright and license details (GPL-2.0).*

</div>