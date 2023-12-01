require 'yaml'
require 'httpx'
require 'date'

secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')
city_id = secrets['weather']['city_id']
timezone = Time.now.getlocal.strftime('%:z')

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

time = Time.now
day_hour = Time.new(time.year, time.month, time.day, 16, 0, 0, timezone).utc.hour

json.each do |row|
  next if !row['dt_txt'].include?("#{day_hour}:00:00")
  break if high.count == 3
  icons       << row['weather'][0]['icon']
  conditions  << row['weather'][0]['main']
  high        << row['main']['temp_max'].to_f.round(0)
end

night_hour = Time.new(time.year, time.month, time.day, 04, 0, 0, timezone).utc.hour
json.each do |row|
  next if !row['dt_txt'].include?("#{night_hour}:00:00")
  break if low.count == 3
  low << row['main']['temp_min'].to_f.round(0)
end

@icons = icons
# conky output
def img_tag(i, x)
  "${image $HOME/.conky/weather_icons/#{@icons[i]}.png -p #{x},350 -s 75x45}"
end

g20  = '${goto 20}'
g160 = '${goto 160}'
c0   = '${color0}'
c60  = '${color gray60}'

out =  "#{c0}Weather: #{city} ${hr 2}\n"
out << "#{g20}#{c0}Sky #{g160}#{c60}#{sky}\n"
out << "#{g20}#{c0}Temperature #{g160}#{c60}#{temp} °C\n"
out << "#{g20}#{c0}Humidity #{g160}#{c60}#{humidity}%\n"
out << "#{g20}#{c0}Visibility #{g160}#{c60}#{visibility} km\n"
out << "#{g20}#{c0}#{days[0]}${goto 180}#{days[1]}${goto 335}#{days[2]}\n\n"
out << "#{img_tag(0, 20)}#{img_tag(1, 180)}#{img_tag(2, 330)}\n\n\n"
out << "${goto 30}#{c60}#{high[0]}/#{low[0]}°C${goto 200}#{high[1]}/#{low[1]}°C${goto 350}#{high[2]}/#{low[2]}°C"
puts out
