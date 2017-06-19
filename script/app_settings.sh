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
# Karabiner-Elements
####################

mkdir -p ~/.config/karabiner
cat > ~/.config/karabiner/karabiner.json << EOF
{
    "global": {
        "check_for_updates_on_startup": true,
        "show_in_menu_bar": true,
        "show_profile_name_in_menu_bar": false
    },
    "profiles": [
        {
            "name": "Default profile",
            "selected": true,
            "simple_modifications": {
                "caps_lock": "left_control"
            }
        }
    ]
}
EOF
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements", hidden:false}'

###################
# jenv
###################

jenv init
jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/
jenv global 1.8
jenv enable-plugin maven

