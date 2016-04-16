#!/usr/bin/env ruby
class Starter

  def initialize
    @conf_dir = './configs/'
    @base_settings = File.readlines "#{@conf_dir}base_settings.conf"
    @configs = %w/sys info battery data_storage network weather/
  end

  def run
    #sleep 20
    remove_old_configs
    generate_new_configs
    execute
  end

  def remove_old_configs
    @configs.each do |config_name|
      file = "./#{config_name}.conf"
      File.delete(file) if File.exist?(file)
    end
  end

  def generate_new_configs
    @configs.each do |config_name|
      current_config = File.readlines "#{@conf_dir}#{config_name}.conf"
      file = File.new "#{config_name}.conf", 'w'
      file.puts(@base_settings + current_config)
      file.close
    end
  end

  def execute
    @configs.each do |config_name|
      system("conky -c ./#{config_name}.conf")
    end
  end

end

Starter.new.run
