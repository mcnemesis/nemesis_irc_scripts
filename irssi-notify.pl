# irssi-notify.pl
use Irssi;

$::VERSION='0.1.0';
%::IRSSI = (
    authors => 'Ashish Shukla,Nemesis Fixx',
    contact => 'gmail.com!wahjava,gmail.com!joewillrich',
    name => 'irssi-notify',
    description => 'Displays a pop-up message for message received [no Net::DBus dependecy]',
    url => 'http://wahjava.wordpress.com/',
    license => 'GNU General Public License',
    changed => '$Date$'
    );

my $APPNAME = 'irssi';
my $NOTIFY_COMMAND = 'notify-send';

my $notify_nick = 'nemesisfixx';

#notification sounds (am asuming KDE IM defaults?)
my $public_sound = '/usr/share/sounds/KDE-Im-Irc-Event.ogg';
my $private_sound = '/usr/share/sounds/KDE-Im-Irc-Event.ogg';

system($NOTIFY_COMMAND, "-c","${APPNAME}", "-t","3000", "-i","info", "${APPNAME} Started", "U are ready to rock IRC!\nYo Notify Script in place too :-)");

sub pub_msg {
    my ($server,$msg,$nick,$address,$target) = @_;

    if ($msg =~ $notify_nick)
    {
        system($NOTIFY_COMMAND,
            "-c", "${APPNAME}:${server}",
                "-t", "3000",
                "-i", "info",
                "Public IRC Message in $target",
                "$nick: $msg",
                );
        #play sound too ;-)
        system('paplay',$public_sound);
    }
}

sub priv_msg {
    my ($server,$msg,$nick,$address) = @_;

    system($NOTIFY_COMMAND,
        "-c", "${APPNAME}:${server}",
            "-t", "3000",
            "-i", "info",
            "Private IRC Message in $target",
            "$nick: $msg",
            );

    #play sound too ;-)
    system('paplay',$private_sound);
}

sub cmd_notifyon {
    my $nick = shift;

    if(!$nick)
    {
	Irssi::print("Current notification nick is $notify_nick .");
    }
    else
    {
	$notify_nick = $nick;
    }
}

Irssi::signal_add_last('message public', \&pub_msg);
Irssi::signal_add_last('message private', \&priv_msg);
Irssi::command_bind('notify-on', \&cmd_notifyon);
