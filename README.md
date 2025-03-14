# Teron's Warrior Tank Tools
This is an addon to help warriors manage their tanking better. 

## Power Word: Shield Remover (PWS Remover)
This is the initial feature of the addon from version 1.0.0. I fixed some of the issues but it's still a work in progress.
It's very easy to use, just click on the minimap button. If the Power Word: Shield icon on the minimap button is green then you will not be shielded by priests (the addon will automatically remove the shields) and if the icon is red then the addon is disabled.

## Tank Mode 
This feature was added as part of the major update to version 1.1.0.
It allows for warriors to choose which Stance they want to tank in. Currently works for Battle and Defensive Stance. Since TWoW introduced a talent which increases your threat in Battle and Berserker Stance, I decided that it would be nice if there was an easier way to choose which stance to tank in without having to change your macros every single time. Using this feature you can just use **"/run TeronTankMode()"** in your macros instead of the ordinary **"/cast ... Stance"** and if the addon is set to Tank Mode then you will automatically switch to Defensive Stance upon casting the macro. If it's disabled then you will use Battle Stance. (Might add an option for Berserker Stance in the future!)
