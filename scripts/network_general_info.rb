require 'yaml'
secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')
interface = secrets['network_interface']

nameservers = `cat /etc/resolv.conf | grep ^nameserver | awk '{print $2}'`.split("\n").join(',')

output = ''
output << "${color0}Gateway IP: $color$gw_ip\n"
output << "${color0}DNS: $color #{nameservers}\n"
output << "${color0}Wi-fi Network: $color${wireless_essid #{interface}}\n"
output << "${color0}Wi-fi Ip: $color${addr #{interface}}\n"
output << "${color0}Signal: $color${wireless_link_qual_perc #{interface}}${goto 95}% ${goto 112}${if_up #{interface}}${wireless_link_bar #{interface}}${else}${color0}No interface$endif\n"
output << "${color0}${goto 20}Down speed: $color${downspeed #{interface}} ${goto 200}${color0}Up speed: $color${upspeed #{interface}}\n"
output << "$color${downspeedgraph #{interface} 12,150 303030 00ff00} ${alignr}$color${upspeedgraph #{interface} 12,150 303030 ff0000}\n"
output << "${color0}Total down: $color${totaldown #{interface}} ${goto 180}${color0}Total up: $color${totalup #{interface}}\n"

puts output
