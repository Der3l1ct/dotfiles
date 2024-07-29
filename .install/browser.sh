# ------------------------------------------------------
# Install tty login and issue
# ------------------------------------------------------
if [ -d ~/dotfiles ] ;then
    current_browser=$(cat ~/dotfiles/.settings/browser.sh)
    if [ ! "$current_browser" == "mercury-browser" ] ;then
        echo -e "${GREEN}"
        figlet "Browser"
        echo -e "${NONE}"
        echo ":: The current browser is $current_browser"
        if gum confirm "Do your want to install Mercury instead?" ;then
            echo ":: Installing Mercury..."
            _installPackagesYay() {
            yay -S mercury-browser-bin
            }
            echo ":: Setting Mercury as Default browser"
            echo "mercury-browser" > ~/dotfiles/.settings/browser.sh
            echo "mercury-browser https://chat.openai.com" > ~/dotfiles/.settings/ai.sh
            xdg-settings set default-web-browser mercury-browser
            echo
            gum spin --spinner dot --title "Recommended to change the browser icon to Firefox in ~/dotfiles/.settings/waybar-quicklinks.json" -- sleep 5
        elif [ $? -eq 130 ]; then
            echo ":: Installation canceled."
            exit 130
        else
            echo ":: Installation of Mercury skipped"
        fi
    fi
else
    echo ":: Mercury will be installed as default browser."
    _installPackagesYay() {
    yay -S mercury-browser-bin
    }
    echo ":: Setting Mercury as Default browser"
    xdg-settings set default-web-browser mercury-browser
fi
