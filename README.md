# Samsung Smart Tag Wireshark Payload Dissector

Parses payload for Samsung Smart Tag locator.

## Installation

1) Go to Help -> About Wireshark -> Folders
2) Find the value for Personal Lua Plugins (For me it was "~/.local/lib/wireshark/plugins")
3) Copy ble-smsmtag.lua to Lua Plugins folder
4) Restart Wireshark or Press Ctrl+Shift+L or Analyze -> Reload Lua Plugins
5) Enjoy

On Ubuntu or other Linux distros you might want to try this one-liner:
```bash
curl https://raw.githubusercontent.com/culhatsker/samsung-smart-tag-wireshark/main/ble-smsmtag.lua > ~/.local/lib/wireshark/plugins/ble-smsmtag.lua
```
Then do 4)

## Limitations

This plugin doesn't support all the modes of operation of the tag, only the main one (after registration)

## Links

* https://arxiv.org/pdf/2210.14702
* https://arxiv.org/pdf/2401.13584

