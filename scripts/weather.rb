require 'yaml'
require 'httpx'
require 'date'

secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')

city_id = secrets['weather']['city_id']

 # required by producing your own API key from  https://openweathermap.org
api_key = secrets['weather']['api_key']
url = "https://api.openweathermap.org/data/2.5/weather?units=metric&id=#{city_id}&APPID=#{api_key}"
response = HTTPX.get url
json = JSON.parse response.body.to_s

# current conditions
temp       = json['main']['temp'].to_f.round(1)
city       = json['name']
humidity   = json['main']['humidity']
visibility = json['visibility'].to_i / 1000
sky        = json['weather'].first['main']

# forecast
url = "https://api.openweathermap.org/data/2.5/forecast?units=metric&id=#{city_id}&APPID=#{api_key}"
response = HTTPX.get url
json = JSON.parse(response.body.to_s)['list']

days       = []
icons      = []
conditions = []
high       = []
low        = []

3.times do |index|
  days << (Date.today + (index + 1)).strftime('%A')
end
json.each do |row|
  next if !row['dt_txt'].include?('15:00:00')
  icons       << row['weather'][0]['icon']
  conditions  << row['weather'][0]['main']
  high        << row['main']['temp_max'].to_f.round(0)
  low         << row['main']['temp_min'].to_f.round(0)
end

@icons = icons
# conky output
def img_tag(i, x)
  "${image $HOME/.conky/weather_icons/#{@icons[i]}.png -p #{x},300 -s 75x45}"
end

g20  = '${goto 20}'
g130 = '${goto 130}'
c0   = '${color0}'
c60  = '${color gray60}'

out =  "#{c0}Weather: #{city} ${hr 2}\n"
out << "#{g20}#{c0}Sky #{g130}#{c60}#{sky}\n"
out << "#{g20}#{c0}Temperature #{g130}#{c60}#{temp} °C\n"
out << "#{g20}#{c0}Humidity #{g130}#{c60}#{humidity}\n"
out << "#{g20}#{c0}Visibility #{g130}#{c60}#{visibility} km\n"
out << "#{g20}#{c0}#{days[0]}${goto 130}#{days[1]}${goto 235}#{days[2]}\n\n"
out << "#{img_tag(0, 10)}#{img_tag(1, 115)}#{img_tag(2, 220)}\n\n\n"
out << "${goto 25}#{c60}#{high[0]}/#{low[0]}°C${goto 140}#{high[1]}/#{low[1]}°C${goto 245}#{high[2]}/#{low[2]}°C"
puts out
