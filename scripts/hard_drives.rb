require 'yaml'
secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')
active_device = secrets['hard_drives']['activity_for']

diskio = "${color}#{active_device}${goto 130}${diskio_write #{active_device}}${goto 240}${diskio_read #{active_device}}${diskiograph #{active_device} 12,160 467f77 303030 -t -l}\n"

free_used_title = "$color0${voffset 5}${goto 100}Total${goto 200}Used${goto 300}Free${goto 420}Used"

partitions = []
secrets['hard_drives']['partitions'].each do |partition_name, partition|
  conky_partition = "${color0}#{partition_name}$color${goto 90}${fs_size #{partition}}${goto 190}${fs_used #{partition}}${goto 290}${fs_free #{partition}}${goto 390}${fs_bar 14,100 #{partition}}${goto 430}$color0${fs_used_perc #{partition}}%"
  partitions << conky_partition + "\n"
end

puts diskio
puts free_used_title
puts '${font Liberation Mono:bold:size=9}' + partitions.inject(:+)
