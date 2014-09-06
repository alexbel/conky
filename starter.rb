class Starter

  def initialize
    @base_settings = File.readlines './config/base_settings.conkyrc'
    @configs = %w[battery data_storage network info weather sys]
  end

  def run
    sleep 5
    remove_old_configs
    generate_new_configs
    execute
  end

  def remove_old_configs
    @configs.each do |config_name|
      file = "./#{config_name}.conkyrc"
      File.delete(file) if File.exist?(file)
    end
  end

  def generate_new_configs
    @configs.each do |config_name|
      current_config = File.readlines "./config/#{config_name}.conkyrc"
      file = File.new "#{config_name}.conkyrc", 'w'
      file.puts(@base_settings + current_config)
      file.close
    end
  end

  def execute
    @configs.each do |config_name|
      system("conky -c ./#{config_name}.conkyrc")
    end
  end

end

Starter.new.run
