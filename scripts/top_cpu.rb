str = ''
(1..8).to_a.each do |num|
  str << "${top name #{num}}${goto 170}${top pid #{num}}${goto 250}${top cpu #{num}}${goto 340}${top mem_res #{num}}\n"
end
puts str
