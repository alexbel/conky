## Conky
<img src='1366x768.png' width='300px'>

## Installation
- rename secrets.yml.example to secrets.yml and put your data in it  
- run 'ruby starter.rb'

## Autostart
Kde plasma 5:  
Create a file `conky.desktop` in `~/.config/autostart` directory and fill it in with the following contents:  
```
[Desktop Entry]
Name=conky
Exec=cd ~/.conky && ruby starter.rb
Type=Application
Terminal=false
```

### Dependencies
Required:  
  - curl
  - ss
  - acpi
  - sensors

Conky libs:  
  - conky-imlib2

Gmail:  
  - ruby >= 1.9.3

  gems:  
  - ruby-gmail
  - mime

Install gem: gem install gem_name  

Weather:  
  - [wunderground](https://github.com/wnadeau/wunderground) gem
  - api_key from http://www.wunderground.com/weather/api/
