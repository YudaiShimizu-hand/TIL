# Dockerを使ってsystemSpec


https://qiita.com/suketa/items/d783ac61c2a3e4c16ad4
https://qiita.com/na-tsune/items/91630257294aa0ea4fc8

docker-compose.yml
```
version: '3'
services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=postgres
  web:
    build: .
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/docker_for_rails27
    ports:
      - "3000:3000"
    depends_on:
      - db
      - selenium_chrome
    environment:
      - "SELENIUM_DRIVER_URL=http://selenium_chrome:4444/wd/hub"
  selenium_chrome:
    image: selenium/standalone-chrome-debug
    logging:
      driver: none
    ports:
      - 4444:4444

```

Gemfile
```
group :development, :test do
  ...
  gem 'rspec-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end
```

```
$ docker-compose up -d
$ docker-compose exec web bash

# 以下は web コンテナ内で実行します。
$ bundle install

$ bin/rails g rspec:install
```

rails_helper.rb
```ruby
# 以下の1行を有効にします。
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

```
capybara.rb
```ruby
require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, options: {
      browser: :remote,
      url: ENV.fetch("SELENIUM_DRIVER_URL"),
      desired_capabilities: :chrome
    }
    Capybara.server_host = 'web'
    Capybara.app_host='http://web'
  end
end
```

rails_helper.rb
```ruby
Capybara.register_driver :remote_chrome do |app|
  url = "http://chrome:4444/wd/hub"
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => {
      "args" => [
        "no-sandbox",
        "headless",
        "disable-gpu",
        "window-size=1680,1050"
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end

#~

RSpec.configure do |config|

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
#~
end
```

.RSpec
```
- --require spec_helper
+ --require rails_helper
```

今回はchromeがないよーっていうエラーで悩まされた。
主に解決に至ったコマンドをまとめてみた。
