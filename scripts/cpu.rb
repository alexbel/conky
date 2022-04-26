string = ''
cpu_freqs = `cat /proc/cpuinfo | grep MHz | awk '{print $4}'`.split("\n").map { |freq| freq.to_f.round }
physical_cores = `cat /proc/cpuinfo | grep cores | uniq |  awk '{print $4}'`.to_i
physical_cores.times do |index|
  core_index = index + 1
  freq = cpu_freqs[index]
  string << "${color0}CPU Core #{core_index}: $color #{freq}MHz ${color0} Load: $color${cpu cpu#{core_index}}%\n"
  string << "${cpugraph cpu#{core_index} 18,350 303030 467f77}\n"
end

puts string
