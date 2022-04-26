str = ''
(1..8).to_a.each do |num|
 str << "${top_mem name #{num}}${goto 170}${top_mem pid #{num}}${goto 250}${top_mem cpu #{num}}${goto 340}${top_mem mem_res #{num}}\n"
end
puts str
