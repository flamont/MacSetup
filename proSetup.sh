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
echo "###############################################" $red

echo "Are you sure you want to run this script?" $magenta
echo "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  echo "Please go read the script, it only takes a few minutes" $red
  exit
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "###############################################" $red

#install Brew
echo "###############################################" $red

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

echo "###############################################" $red


#Cask
echo "###############################################" $red
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
brew install iterm2
brew install docker
brew install visual-studio-code
brew install sublime-text
brew install rstudio
brew install processing
brew install  anaconda
brew install runjs
brew install cakebrew
brew install sourcetree
brew install github
brew install mysqlworkbench
brew install notion
brew install slack
brew install discord
brew cask install google-chrome
brew install firefox
brew install microsoft-edge
brew install qgis
brew install spotify
brew install xcodes
brew install betterdisplay
brew install colour-contrast-analyser
brew install blender
brew install figma
brew install adobe-creative-cloud

#geo
brew install gdal
brew install geos
brew install spatialindex

#manual
#mozillaDev
#DisplayLinkManager
#adobe
#photoshop
#Illustrator
#Dimension
#indesign
#AE
#Acrobat

#clean old version
brew cleanup

echo "###############################################" $red


#Install from appstore
echo "###############################################" $red

echo "Install apps from app store"

# ### find app ids with: mas search "app name"
# brew install mas

# ### Mas login is currently broken on mojave. See:
# ### Login manually for now.

# echo "Need to log in to App Store manually to install apps with mas...." $red
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
# 	echo "App Store login not complete. Skipping installing App Store Apps" $red
# fi

echo "###############################################" $red



#SystemSetup
echo "###############################################" $red

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

echo "###############################################" $red


#npm package
echo "###############################################" $red

npm install -g prettier
npm install -g eslint

echo "###############################################" $red


#pip
echo "###############################################" $red

echo "Python package"

pip3 install pillow
pip3 install pysal
pip3 install pandas
pip3 install geopandas
pip3 install matplotlib 
pip3 install rtree
pip3 install ogr
pip3 install descartes
pip3 install geopy
pip install basemap

 #conda install -c conda-forge geopandas

echo "###############################################" $red


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
echo "Done!" $cyan
echo ""
echo ""
echo "################################################################################" $white
echo ""
echo ""
echo "Note that some of these changes require a logout/restart to take effect." $red
echo ""
echo ""
echo -n "Check for and install available OSX updates, install, and automatically restart? (y/n)? "
read response
if [ "$response" != "${response#[Yy]}" ] ;then
    softwareupdate -i -a --restart
fi



