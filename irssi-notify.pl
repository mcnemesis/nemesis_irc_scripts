# irssi-notify.pl
use Irssi;
use Net::DBus;

$::VERSION='0.0.2';
%::IRSSI = (
    authors => 'Ashish Shukla,Nemesis Fixx',
    contact => 'gmail.com!wahjava,gmail.com!joewillrich',
    name => 'irssi-notify',
    description => 'Displays a pop-up message for message received (and play notification sound)',
    url => 'http://wahjava.wordpress.com/',
    license => 'GNU General Public License',
    changed => '$Date$'
);

my $APPNAME = 'irssi';

my $bus = Net::DBus->session;
my $notifications = $bus->get_service('org.freedesktop.Notifications');
my $object = $notifications->get_object('/org/freedesktop/Notifications',
					'org.freedesktop.Notifications');

#--------- Changes (for me) --------------#
my $notify_nick = 'nemesisfixx';
#notification sounds (am asuming KDE IM notification sound defaults?)
my $public_sound = '/usr/share/sounds/KDE-Im-Irc-Event.ogg';
my $private_sound = '/usr/share/sounds/KDE-Im-Irc-Event.ogg';
#-----------------------------------------#

# $object->Notify('appname', 0, 'info', 'Title', 'Message', [], { }, 3000);

sub pub_msg {
    my ($server,$msg,$nick,$address,$target) = @_;

    if ($msg =~ $notify_nick)
    {
        $object->Notify("${APPNAME}:${server}",
                0,
                'info',
                "Public IRC Message in $target",
                "$nick: $msg",
                [], { }, 3000);
        #play sound too ;-)
        system('paplay',$public_sound);
    }
}

sub priv_msg {
    my ($server,$msg,$nick,$address) = @_;
    $object->Notify("${APPNAME}:${server}",
		    0,
		    'info',
		    'Private IRC Message',
		    "$nick: $msg",
		    [], { }, 3000);
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
