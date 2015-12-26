## Conky configuration
<img src='1366x768.png' width='900px'>

## Installation
- Clone repo `git clone https://github.com/alexbel/conky.git ~/.conky`
- Install dependencies (see below)
- Install the necessary ruby gems (see below)
- Rename secrets.yml.example to secrets.yml and put your data in it
- Run 'ruby starter.rb' or just './starter.rb'

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

### Conky versions
- Use `master` branch for conky >= 1.10.0
- Use `1.9` branch for conky <= 1.9.1

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
