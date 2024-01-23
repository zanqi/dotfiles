curl https://raw.githubusercontent.com/zanqi/dotfiles/main/setup.sh > setup.sh
chmod +x setup.sh
./setup.sh

save  
mackup backup --force && mackup uninstall --force

restore  
mackup restore --force && mackup uninstall --force