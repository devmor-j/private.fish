# private.fish

`private.fish` is a lightweight Fish shell extension that indicates **private mode** sessions in the prompt using a ghost icon 👻. Each terminal is tracked independently, displaying a per-terminal session count.

## Features

- **Private mode indicator**: Shows a ghost icon `👻` in the prompt for private Fish sessions.
- **Root mode indicator**: Shows a fire icon `🔥` in the prompt when running as root.
- **Per-terminal session tracking**: Counts active private sessions **per terminal**, independent of other terminals.
- **Customizable behavior** via variables: control symbol and count display.
- **Works with any prompt**: the icon is added to your existing prompt automatically — no prompt changes needed.

---

## Installation

To install the `private.fish` plugin, use [Fisher](https://github.com/jorgebucaran/fisher) by running the following command:

```bash
fisher install devmor-j/private.fish
```

> After installation, Fish will automatically detect private mode and display the ghost icon in your prompt.

---

## Configuration / Defaults

| Variable              | Default | Description                                                |
| --------------------- | ------- | ------------------------------------------------------------ |
| `private_symbol`      | `👻`    | The icon used for private sessions.                        |
| `root_symbol`         | `🔥`    | The icon prepended when running as root.                   |
| `private_show_count`  | `true`  | Show a numeric count next to the ghost icon.               |
| `private_fish_autoclear` | `false` | If true, records `echo` output and erases those lines on exit. |

### Configuration

To customize the behavior of `private.fish`, you can set the following variables in your Fish configuration file (`config.fish`) **before** loading the plugin. Here is an example:

```fish
set -U private_symbol "🔒"
set -U private_show_count false
```

To increase the spacing between emojis, adjust the variables accordingly.

---

## Usage

Open a Fish terminal in private mode — you’ll see the ghost icon 👻 in your prompt:

```bash
fish -P
# or fish --private
```

- If multiple private sessions share the same terminal and `private_show_count=true`, the icon shows the count, e.g., `👻3`.
- Each terminal is independent, so counts don’t interfere with each other.

**Note:** When the **root** user is active, the plugin will display a 🔥 icon by default to indicate increased privileges.

## Known limitations

- **Cross-user counts are separate**: a root and a non-root shell on the same terminal keep independent counts, because root lacks `XDG_RUNTIME_DIR` (dropped by sudo's `env_reset`) and falls back to its own state dir. A shared cross-user count is intentionally unsupported (`kill -0` EPERM and file permissions make it unsafe).

## License

MIT License. Free to use and modify.
