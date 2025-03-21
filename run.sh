#!/usr/bin/env bash
prismdir=~/.local/share/PrismLauncher
savedir=~/afs/.moulinettemc

exec 3>&1
exec 1>& /dev/null

echo "Enter your pseudo:" >&3
read account
echo >&3

[[ ! -d $prismdir ]] && mkdir $prismdir
[[ ! -d $savedir ]] && mkdir $savedir

echo "Downloading gamefiles..." >&3
if wget https://github.com/MoulinetteMC/MoulinetteMC/archive/refs/heads/main.zip; then 
   echo "Decompressing gamefiles..." >&3
   unzip ./main.zip -d "$prismdir/instances/"
   mv $prismdir/instances/MoulinetteMC-main/ $prismdir/instances/MoulinetteMC/
else 
   echo "\033[31mFailed to download instance\033[0m" >&3
   pause
fi

echo "Import player's settings..." >&3
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

echo "Export player's settings..." >&3
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