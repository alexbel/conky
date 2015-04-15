def smart_space(item1=nil)
  num_spaces = 23
  spaces = num_spaces - item1.length
  output = ''
  spaces.times { output << ' ' }
  output
end

network_lines = %x(ss -ntup)
network_lines = network_lines.split("\n")[1..8]
output = ''

network_lines.each_with_index do |line, index|
  columns = line.split(' ')
  protocol = columns.first
  ip_address = columns[5]
  name = columns.last.split('"')[1]
  if protocol && ip_address && name
    output << protocol << '     ' << ip_address << smart_space(ip_address) << name << "\n"
  end
end

puts output
