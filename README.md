#mChat
###A lightweight, easy to use, modern chat to replace the default ROBLOX chat.

*To follow progress of mChat, check out my Trello board: https://trello.com/b/Z9U5O2pH/mchat.*

##Features
Currently, mChat has the following features:
- Multi-Line Chat
- Whispering & Muting Capabilities
- FilterStringAsync()
- Shift + 7 & Enter Support

##Disclaimer
Feel free to use, redistribute, or modify the code here. All that I ask in return is for proper credit to be allocated and for it to not be sold to others. Thanks for understanding, and enjoy!

##Installation
To install mChat, simply paste the following into your command bar in Studio **(Credit to Nevermore Engine by @Quenty and its contributers for the idea/concept of the installer.)**:
```lua
local ht = game:GetService("HttpService") local htp = ht.HttpEnabled ht.HttpEnabled = true loadstring(ht:GetAsync("https://raw.githubusercontent.com/m0dulum/mChat/master/install.lua"))() ht.HttpEnabled = htp
```
##Version History
###Version 1.2
- Fixed multi-line. Should be functioning if you installed through the installer.

###Version 1.1
- Added Enter/Shift + 7 support
- Added /mute and /unmute
- Added FilterStringAsync()

###Version 1.0
- First stable release of mChat
