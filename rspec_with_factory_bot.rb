# frozen_string_literal: true

gem_group :development, :test do
  gem 'awesome_print'
  gem 'fasterer'
  gem 'pry-rails'
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-performance'

  gem 'rspec-rails'
end

gem_group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

after_bundle do
  rails_command 'generate rspec:install'
  environment 'config.factory_bot.definition_file_paths = ["spec/factories"]',
              env: 'test'

  shoulda_configuration = <<~CODE

    #** Added by rails application template
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
  CODE
  run "echo '#{shoulda_configuration}' >> spec/rails_helper.rb"
end
