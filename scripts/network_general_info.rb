nameservers = `cat /etc/resolv.conf | grep ^nameserver | awk '{print $2}'`.split("\n").join(',')

output = ''
output << "${color0}Gateway IP: $color$gw_ip\n"
output << "${color0}DNS: $color #{nameservers}\n"
output << "${color0}Wi-fi Network: $color${wireless_essid wlp3s0}\n"
output << "${color0}Wi-fi Ip: $color${addr wlp3s0}\n"
output << "${color0}Signal: $color${wireless_link_qual_perc wlp3s0}${goto 95}% ${goto 112}${if_up wlp3s0}${wireless_link_bar wlp3s0}${else}${color0}No wlan0$endif\n"
puts output
