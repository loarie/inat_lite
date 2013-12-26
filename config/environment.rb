# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
InatLite::Application.initialize!

#On Heroku rather use use environment variables https://devcenter.heroku.com/articles/config-vars
unless Rails.env.production?
  ENV = YAML.load_file("#{Rails.root}/config/config.yml")
end
