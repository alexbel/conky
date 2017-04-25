string = ''
cpu_freqs = `cat /proc/cpuinfo | grep MHz | awk '{print $4}'`.split("\n").map { |freq| freq.to_f.round }
cpu_freqs.each_with_index do |freq, index|
  core_index = index + 1
  string << "${color0}CPU Core #{core_index}: $color #{freq}MHz ${color0} Load: $color${cpu cpu#{core_index}}% $color0${goto 260}Temp: $color${exec sensors | grep 'Core #{index}' | cut -c17-18}°\n"
  string << "${cpugraph cpu#{core_index} 12,330 303030 467f77}\n"
end

puts string
