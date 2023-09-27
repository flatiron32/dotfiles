#!/usr/bin/env bash
echo "#### APP SETTINGS BEGINNING #####"

####################
# Login items
####################

#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/path/to/itemname", hidden:false}' > ~/.dotfiles/backup/list_loginitems.txt
## Add items (commented but left for future use)
## osascript -e 'tell application "System Events" to make login item at end with properties {path:"/path/to/itemname", hidden:false}'
## Delete items (commented but left for future use)
## osascript -e 'tell application "System Events" to delete login item "itemname"'
#
#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/BeardedSpice.app", hidden:false}'
#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Caffeine.app", hidden:false}'
#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Dropbox.app", hidden:false}'
#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Flux.app", hidden:false}'


####################
# vim
####################

vim +PluginInstall +qall
