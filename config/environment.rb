# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
InatLite::Application.initialize!

#Switched to Forman
unless Rails.env.production?
  ENV = YAML.load_file("#{Rails.root}/config/config.yml")
end
