# lain — SDDM Theme

> *"present day — present time"*

![background](background.png)

A minimal SDDM login theme inspired by **Serial Experiments Lain**. Dark blues, monospace typography, scanline overlay, and floating code particles. Built for Wayland and X11.

---

## Files

| File | Description |
|---|---|
| `Main.qml` | Main theme UI — layout, animations, login logic |
| `theme.conf` | Theme configuration (background path, HiDPI) |
| `metadata.desktop` | Theme metadata for SDDM |
| `background.png` | Wallpaper |
| `keyboard.conf` | Keyboard layout configuration (`/etc/sddm.conf.d/`) |
| `install-lain-sddm.sh` | Automated installer script |

---

## Requirements

- SDDM ≥ 0.19
- Qt 5 / QtQuick 2.0
- `SddmComponents` 2.0 (included with SDDM)

---

## Installation

### Automatic (recommended)

Place all theme files in the same directory as the installer, then run:

```bash
chmod +x install-lain-sddm.sh
sudo ./install-lain-sddm.sh
```

The script will:
- Copy theme files to `/usr/share/sddm/themes/lain/`
- Install `keyboard.conf` to `/etc/sddm.conf.d/`
- Back up any existing configs before overwriting

### Manual

```bash
# Copy theme files
sudo mkdir -p /usr/share/sddm/themes/lain
sudo cp Main.qml theme.conf metadata.desktop background.png /usr/share/sddm/themes/lain/

# Copy keyboard config
sudo cp keyboard.conf /etc/sddm.conf.d/keyboard.conf

# Set the active theme
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=lain" | sudo tee /etc/sddm.conf
```

---

## Configuration

### `theme.conf`

```ini
[General]
background=/usr/share/sddm/themes/lain/background.png

[Wayland]
EnableHiDPI=true
```

Change `background` to point to any image you prefer.

### `keyboard.conf`

```ini
[X11]
XkbLayout=es
XkbVariant=
```

Change `XkbLayout` to your locale (e.g. `us`, `de`, `fr`).

---

## Customization

All visual settings live in `Main.qml`. Notable values:

| What | Where in `Main.qml` | Default |
|---|---|---|
| Background color | `Rectangle { color: ... }` (root) | `#000208` |
| Clock color | `clockText { color: ... }` | `#3a8fd4` |
| Scanline opacity | `Canvas { opacity: ... }` | `0.045` |
| Particle count | `Repeater { model: ... }` | `28` |
| Panel width | `loginPanel { width: ... }` | `310` |
| Tagline text | `tagline { text: ... }` | `"present day  -  present time"` |

---

## Preview

The login panel sits on the right side of the screen and includes:

- Flickering tagline in the top-right corner
- Live clock with date below it
- User selector, password field, session selector
- `REBOOT` / `SHUTDOWN` buttons at the bottom-right
- Hostname display at the bottom-left

---

## License

MIT
