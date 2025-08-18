# 🕵️‍♂️ private.fish

A lightweight Fish shell extension to indicate **private mode** sessions in your prompt with a ghost icon 👻. ~~Each terminal session is tracked independently, and the icon can show a per-terminal activity count.~~

---

## 🚀 Features

- **Private mode indicator**: Shows a ghost icon `👻` in the prompt for private Fish sessions.
- ~~**Per-terminal session tracking**: Counts actions/outputs **per terminal**, independent of other terminals.~~
- **Customizable behavior** via universal variables: control symbol, count display, and optional auto-recording.
- **Automatic prompt wrapping**: Works with any Fish prompt without modifying it manually.
- ~~**Optional output recording**: Save private outputs to a log file for the session.~~

---

## ⚙️ Installation

Install using [fisher](https://github.com/jorgebucaran/fisher):

```bash
fisher install devmor-j/private.fish
```

> Fish will automatically detect private mode and display the ghost icon in your prompt.

---

## 📝 Configuration / Defaults

| Variable                 | Default | Description                                          |
| ------------------------ | ------- | ---------------------------------------------------- |
| `private_symbol`         | `👻`    | The icon used for private sessions.                  |
| `private_show_count`     | `true`  | Show a numeric count next to the ghost icon.         |
| `private_fish_autoclear` | `false` | If true, records outputs in a per-terminal log file. |

You can override defaults by setting these variables in your Fish config (`config.fish`) before loading `private.fish`. Example:

```fish
set -U private_symbol "🔒"
set -U private_show_count false
set -U private_fish_autoclear true
```

### 🔒 Privacy Emojis

Here are some emojis you can use for privacy indicators:

- 👻 **Ghost (default)**
- 🔒 Lock
- 🔑 Key
- 🗝️ Old Key
- 🔐 Closed Lock With Key
- 🛡️ Shield
- 🕵️‍♂️ Detective
- 🕶️ Sunglasses / Incognito
- 🏠 House / Private Space
- 📝 Hidden Note
- 🙈 See-No-Evil Monkey
- 🐟 Fish
- 🐠 Tropical Fish
- 🐡 Pufferfish
- 🐬 Dolphin
- 🦈 Shark
- 🐙 Octopus

---

## 💡 Usage

1. Open a Fish terminal in private mode:

```bash
fish -P
# or fish --private
```

2. You’ll see the ghost icon `👻` in your prompt.
3. If you have multiple commands recorded in the session and `private_show_count=true`, the icon will show the count, e.g., `👻3`.
4. ~~Each terminal is independent, so counts don’t interfere with each other.~~

<!-- ---

## ✨ Optional Features

- **Per-terminal output logging** (`private_fish_autoclear=true`):
  Records your commands/output to a session log file at `$private_state/private_<PID>.log`. -->

---

## 📝 License

MIT License. Free to use and modify.

This plugin was developed with AI assistance; Expect bugs and compatibility issues until they are fixed.
