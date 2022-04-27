def smart_space(item1=nil)
  num_spaces = 23
  spaces = num_spaces - item1.length
  output = ''
  spaces.times { output << ' ' }
  output
end

network_lines = %x(ss -ntup)
network_lines = network_lines.split("\n")[1..11]
result = []
process_to_ip = []

network_lines.each_with_index do |line, index|
  columns = line.split(' ')
  protocol = columns.first
  ip_address = columns[5]
  name = columns.last.split('"')[1]
  if protocol && ip_address && name
    str = protocol << '     ' << ip_address << smart_space(ip_address) << name
    process_ip = "#{name}|#{ip_address}"
    next if process_to_ip.include?(process_ip)
    process_to_ip << process_ip
    h = {process_name: name, data: str}
    result << h
  end
end
output = result.sort_by { |h| h[:process_name] }.map{|h| h[:data]}.join("\n")
puts output
