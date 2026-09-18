# dizziee.layout-indicator

Shows the current Hyprland window layout (dwindle, master, monocle, scrolling) in the Omarchy bar.

## Installation

```sh
omarchy plugin add https://github.com/JJDizz1L/dizziee.layout-indicator.git --enable
```

### Then place it in your bar layout with
`omarchy bar plugin add dizziee.layout-indicator [--section <left|center|right>]`</br>

Suggested placement:
```
omarchy bar plugin add dizziee.layout-indicator --section right
```

You can validate the plugin at any time with:

```sh
omarchy plugin validate ~/.config/omarchy/plugins/dizziee.layout-indicator
```

## Updating

To pull the latest version of the plugin:

```sh
omarchy plugin update dizziee.layout-indicator --yes
```

## Configuration

Configuration lives in `~/.config/omarchy/shell.json`.

No configurable options.

## Preview

![preview](preview.png)

## Uninstall

```sh
omarchy plugin remove dizziee.layout-indicator
```

## License

MIT
