#!/bin/sh

echo "I  ❤️  🍎"
echo "@FLD ProSetup"
echo "by @FLD"
echo "https://francis-lamontagne.com"

#-----------
#Based on 
# nnj (https://github.com/nnja/new-computer/blob/master/setup.sh)
# ruyadorno (https://github.com/ruyadorno/installme-osx/)
# millermedeiros (https://gist.github.com/millermedeiros/6615994)
# brandonb927 (https://gist.github.com/brandonb927/3195465/)
#----------- 

# Set the colours you can use
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

# Resets colors
#reset=`tput sgr0`

#run alert
cecho "###############################################" $red

cecho "Are you sure you want to run this script?" $magenta
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cecho "###############################################" $red

#install Brew
cecho "###############################################" $red

echo "Install Homebrew"
if test ! $(which brew)
then
## Don't prompt for confirmation when installing homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi
#manage brew
brew upgrade
brew update
brew tap caskroom/cask

cecho "###############################################" $red


#Cask
cecho "###############################################" $red
echo "Brew cask"
#dev + env
brew install git  
brew install zsh
brew install python3
brew install nvm
brew install node
brew install yarn
brew install pnpm
brew install rename

brew cask install iterm2
brew cask install docker
brew cask install visual-studio-code
brew install --cask sublime-text
brew install --cask rstudio
brew install --cask processing
brew install --cask anaconda
brew install --cask runjs
brew install --cask cakebrew
brew install --cask cyberduck
brew install --cask filezilla

brew install --cask sourcetree
brew install --cask github
brew install --cask mysqlworkbench
brew install --cask dbschema
brew install --cask postman

brew cask install notion
brew cask install slack
brew install --cask discord
brew cask install google-chrome
brew install firefox
brew install --cask microsoft-edge
brew install --cask opera
brew install --cask qgis
brew install --cask spotify
brew install --cask xcodes
brew install --cask betterdisplay
brew install --cask colour-contrast-analyser

brew install --cask blender
brew install --cask figma
brew install --cask adobe-creative-cloud

brew install --cask screaming-frog-seo-spider

brew install --cask ultimaker-cura
brew install --cask arduino
brew install --cask autodesk-fusion360
brew install --cask creality-slicer
brew install --cask raspberry-pi-imager
brew install --cask utm


#manual
#------
#mozillaDev
#DisplayLinkManager
#photoshop
#Illustrator
#indesign
#Acrobat
#trello

#clean old version
brew cleanup

cecho "###############################################" $red


#Install from appstore
cecho "###############################################" $red

echo "Install apps from app store"

# ### find app ids with: mas search "app name"
# brew install mas

# ### Mas login is currently broken on mojave. See:
# ### Login manually for now.

# cecho "Need to log in to App Store manually to install apps with mas...." $red
# echo "Opening App Store. Please login."
# open "/Applications/App Store.app"
# echo "Is app store login complete.(y/n)? "
# read response
# if [ "$response" != "${response#[Yy]}" ]
# then
# 	mas install 907364780  # Tomato One - Pomodoro timer
# 	mas install 485812721  # Tweetdeck
# 	mas install 668208984  # GIPHY Capture. The GIF Maker (For recording my screen as gif)
# 	mas install 1351639930 # Gifski, convert videos to gifs
# 	mas install 414030210  # Limechat, IRC app.
# else
# 	cecho "App Store login not complete. Skipping installing App Store Apps" $red
# fi

cecho "###############################################" $red



#SystemSetup
cecho "###############################################" $red

#AutoHide Dock
defaults write com.apple.dock autohide -bool true

#Recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
#defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
#defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#1password
brew install 1password

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable the warning when changing a file extension
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Remove the sleep image file to save disk space? (y/n)"
echo "(If you're on a <128GB SSD, this helps but can have adverse affects on performance. You've been warned.)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo rm /Private/var/vm/sleepimage
  echo "Creating a zero-byte file instead"
  sudo touch /Private/var/vm/sleepimage
  echo "and make sure it can't be rewritten"
  sudo chflags uchg /Private/var/vm/sleepimage
fi

echo "Disable display from automatically adjusting brightness? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
fi

echo ""
echo "Disable keyboard from automatically adjusting backlight brightness in low light? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
fi

echo ""
echo "Show dotfiles in Finder by default? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.finder AppleShowAllFiles TRUE
fi

echo ""
echo "Show all filename extensions in Finder by default? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
fi

echo ""
echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo ""
echo "Disable local Time Machine backups? (This can take up a ton of SSD space on <128GB SSDs) (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  hash tmutil &> /dev/null && sudo tmutil disablelocal
fi

cecho "###############################################" $red


#npm package
cecho "###############################################" $red

npm install -g prettier
npm install -g eslint

#vscodeExtension


cecho "###############################################" $red


###############################################################################
# Chrome, Safari, & WebKit
###############################################################################


echo ""
echo "Privacy: Don't send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo ""
echo "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true



#End Section

echo ""
cecho "Done!" $cyan
echo ""
echo ""
cecho "################################################################################" $white
echo ""
echo ""
cecho "Note that some of these changes require a logout/restart to take effect." $red
echo ""
echo ""
echo -n "Check for and install available OSX updates, install, and automatically restart? (y/n)? "
read response
if [ "$response" != "${response#[Yy]}" ] ;then
    softwareupdate -i -a --restart
fi



