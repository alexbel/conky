str = ''
(1..8).to_a.each do |num|
  str << "${top name #{num}}${goto 170}${top pid #{num}}${goto 220}${top cpu #{num}}${goto 285}${top mem_res #{num}}\n"
end
puts str
