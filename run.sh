#!/usr/bin/env bash
prismdir=~/.local/share/PrismLauncher
savedir=~/afs/.moulinettemc

echo $1
echo $2
echo $3
echo $4

read -p "Enter your pseudo: " account

[[ ! -d $prismdir ]] && mkdir $prismdir
[[ ! -d $savedir ]] && mkdir $savedir

if wget https://github.com/MoulinetteMC/MoulinetteMC/archive/refs/heads/main.zip; then 
   unzip ./main.zip -d "$prismdir/instances/"
else 
   echo "Failed to download instance"
fi

mv $prismdir/instances/MoulinetteMC-main/ $prismdir/instances/MoulinetteMC/

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