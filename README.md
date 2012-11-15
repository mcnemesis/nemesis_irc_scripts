nemesis_irc_scripts
===================

IRC (irssi) scripts to re-use / share:

irssi-notify.pl 
---------------
(originally by Ashish Shukla) : 

    - Displays a pop-up message for message received (No-longer depends on Net::DBus -- uses notify-send)

    - Plays sound notification alongside the notification pop-up (new addition)

**Usage**:

    - copy the script to some path, preferably ~/.irssi/scripts/irssi-notify.pl
    - [optionally] symlink the script into ~/.irssi/scripts/autorun/, so that irssi loads at automatically at startup
    - /connect -> /join and then /notify-on my_nick (to get notifications for public and private messages to nick "my_nick")
    - [not advised] indulge in sending yourself /msg my_nick, just to have fun ;-)

**NOTE**:

If the notification sound doesn't work on your system (I assumed some default notification sounds on mine), open the script and
point the variables "private_sound" and "public_sound" (at the top of the script) to point at your preferred sound files.

**Assumptions**:

    -- that the paplay command is installed (all modern *nix systems ought to have it)
    -- and that the notification sound file /usr/share/sounds/KDE-Im-Irc-Event.ogg exists
    -- and the perl exists
    -- and that the notify-send command is on the PATH
