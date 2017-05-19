require 'yaml'
require 'wunderground'

secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')

city = secrets['wunderground']['city']
state = secrets['wunderground']['state']

degree = 'c'
measurement = 'celsius'
if secrets['wunderground']['unit_of_measurement'].to_s.downcase == 'fahrenheit'
  degree = 'f'
  measurement = 'fahrenheit'
end

distance_unit = 'km'
if secrets['wunderground']['system'].to_s.downcase == 'imperial'
  distance_unit = 'mi'
end

 # required by producing your own API key from http://www.wunderground.com/weather/api/
w = Wunderground.new secrets['wunderground']['api_key']

file = '/tmp/weather.txt'

# current conditions
current_conditions = w.conditions_for state, city
json = current_conditions['current_observation']
temp       = json["temp_#{degree}"]
city       = json['display_location']['city']
humidity   = json['relative_humidity']
feelslike  = json["feelslike_#{degree}"]
visibility = json["visibility_#{distance_unit}"]
weather    = json['weather']

# forecast
forecast = w.forecast_for state, city
json = forecast['forecast']['simpleforecast']['forecastday']

days       = []
icons      = []
conditions = []
high       = []
low        = []
3.times do |index|
  index = index + 1
  days       << json[index]['date']['weekday']
  icons      << json[index]['icon']
  conditions << json[index]['conditions']
  high       << json[index]['high'][measurement]
  low        << json[index]['low'][measurement]
end

File.open(file, 'w') do |f|
  f.write("#{city}\n")
  f.write("#{weather}\n")
  f.write("#{temp}\n")
  f.write("#{humidity}\n")
  f.write("#{feelslike}\n")
  f.write("#{visibility}\n")

  3.times do |index|
    f.write("#{days[index]}\n")
    f.write("#{icons[index]}\n")
    f.write("#{conditions[index]}\n")
    f.write("#{high[index]}\n")
    f.write("#{low[index]}\n")
  end
end

@icons = icons

# conky output
def img_tag(i, x)
  "${image $HOME/.conky/weather_icons/#{@icons[i]}.png -p #{x},320 -s 75x45}"
end

g20  = '${goto 20}'
g130 = '${goto 130}'
c0   = '${color0}'
c60  = '${color gray60}'

out =  "#{c0}Weather: #{city} ${hr 2}\n"
out << "#{g20}#{c0}Sky #{g130}#{c60}#{weather}\n"
out << "#{g20}#{c0}Temperature #{g130}#{c60}#{temp} °C\n"
out << "#{g20}#{c0}Humidity #{g130}#{c60}#{humidity}\n"
out << "#{g20}#{c0}Feels like #{g130}#{c60}#{feelslike} °C\n"
out << "#{g20}#{c0}Visibility #{g130}#{c60}#{visibility} #{distance_unit}\n"
out << "#{g20}#{c60}#{days[0]}${goto 130}#{days[1]}${goto 235}#{days[2]}\n\n"
out << "#{img_tag(0, 10)}#{img_tag(1, 115)}#{img_tag(2, 220)}\n\n\n"
out << "${goto 30}#{c60}#{high[0]}/#{low[0]}°#{degree.upcase}${goto 130}#{high[1]}/#{low[1]}°#{degree.upcase}${goto 240}#{high[2]}/#{low[2]}°#{degree.upcase}"
puts out
