#!/usr/bin/env bash
prismdir=~/.local/share/PrismLauncher
savedir=~/afs/.moulinettem

echo "Enter your pseudo:"
read account
echo

[[ ! -d $prismdir ]] && mkdir $prismdir
[[ ! -d $savedir ]] && mkdir $savedir

echo "\033[32mDownloading gamefiles...\033[0m"
if wget https://github.com/MoulinetteMC/MoulinetteMC/archive/refs/heads/main.zip; then 
   echo "\033[32mDecompressing gamefiles...\033[0m"
   unzip ./main.zip -d "$prismdir/instances/"
   mv $prismdir/instances/MoulinetteMC-main/ $prismdir/instances/MoulinetteMC/
else 
   echo "\033[31mFailed to download instance\033[0m"
   pause
fi

echo "\033[32mImport player's settings...\033[0m"
[[ -f "$savedir/accounts.json" ]] &&
   cp $savedir/accounts.json $prismdir

[[ -f "$savedir/prismlauncher.cfg" ]] && 
   cp $savedir/prismlauncher.cfg $prismdir

[[ -f "$savedir/options.txt" ]] && 
   cp $savedir/options.txt \
      $prismdir/instances/MoulinetteMC/

[[ -d "$savedir/xaero/minimap/" ]] && 
   mkdir /instances/MoulinetteMC/.minecraft/xaero/minimap/Multiplayer_valentinkh.ddns.net/ &&
   cp -r $savedir/xaero/minimap/ \
      $prismdir/instances/MoulinetteMC/.minecraft/xaero/minimap/Multiplayer_valentinkh.ddns.net/

[[ -d "$savedir/xaero/world-map/" ]] &&
   mkdir /instances/MoulinetteMC/.minecraft/xaero/world-map/Multiplayer_valentinkh.ddns.net/ &&
   cp -r $savedir/xaero/world-map/ \
      $prismdir/instances/MoulinetteMC/.minecraft/xaero/world-map/Multiplayer_valentinkh.ddns.net/

nix-shell -p prismlauncher --command "prismlauncher -l MoulinetteMC -a $account"

echo "\033[32mExport player's settings...\033[0m"
[[ -f "$prismdir/accounts.json" ]] &&
   cp $prismdir/accounts.json $savedir/accounts.json

[[ -f "$prismdir/prismlauncher.cfg" ]] && 
   cp $prismdir/prismlauncher.cfg $savedir/prismlauncher.cfg

[[ -f "$prismdir/options.txt" ]] && 
   cp $prismdir/instances/MoulinetteMC/ \
      $savedir/options.txt  

[[ -d "$prismdir/instances/MoulinetteMC/.minecraft/xaero/minimap/Multiplayer_valentinkh.ddns.net/" ]] && 
   cp -r $prismdir/instances/MoulinetteMC/.minecraft/xaero/minimap/Multiplayer_valentinkh.ddns.net/ \
      $savedir/xaero/minimap/

[[ -d "$prismdir/instances/MoulinetteMC/.minecraft/xaero/world-map/Multiplayer_valentinkh.ddns.net/" ]] && 
   cp -r $prismdir/instances/MoulinetteMC/.minecraft/xaero/world-map/Multiplayer_valentinkh.ddns.net/ \
      $savedir/xaero/world-map/