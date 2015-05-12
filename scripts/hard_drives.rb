require 'yaml'
secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')
active_device = secrets['hard_drives']['activity_for']

diskio = "${color}#{active_device}${goto 60}${diskio_write #{active_device}}${goto 130}${diskio_read #{active_device}}${goto 190}${diskiograph #{active_device} 12,147 467f77 303030 -t -l}\n"

free_used_title = "$color0${voffset 5}${goto 85}Free${goto 150}Used${goto 215}Size${goto 290}Used"

partitions = []
secrets['hard_drives']['partitions'].each do |partition_name, partition|
  conky_partition = "${color0}#{partition_name}$color${goto 75}${fs_free #{partition}}${goto 140}${fs_used #{partition}}${goto 205}${fs_size #{partition}}${goto 265}${fs_bar 12,72 #{partition}}${goto 295}$color0${fs_used_perc #{partition}}%"
  partitions << conky_partition + "\n"
end

puts diskio
puts free_used_title
puts '${font Liberation Mono:bold:size=9}' + partitions.inject(:+)
