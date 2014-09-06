def smart_space(item1)
  num_spaces = 23
  spaces = num_spaces - item1.length
  output = ''
  spaces.times { output << ' ' }
  output
end

network_lines = %x[netstat -ntup 2>/dev/null | grep ESTABLISHED]
network_lines = network_lines.split("\n")[0..8]
output = ''
network_lines.each_with_index do |line, index|
  next if [0,1].include? index
  protocol = line.split(' ')[0]
  ip_address = line.split(' ')[4]
  name = line.split(' ')[6].split('/').last
  output << protocol << '     ' << ip_address << smart_space(ip_address) << name << "\n"
end
puts output
