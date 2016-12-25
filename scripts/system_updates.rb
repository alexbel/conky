require 'mkmf'

# do not create mkfm.log file
module MakeMakefile::Logging
  @logfile = File::NULL
end

output = ''

# arch linux
if find_executable0 'pacman'
  output = `sudo pacman -Sy >/dev/null && pacman -Qu | wc -l`
end

puts output
