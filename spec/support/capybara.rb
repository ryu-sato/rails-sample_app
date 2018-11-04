require 'capybara/rspec'
require 'selenium-webdriver'

# ref. https://tech.speee.jp/entry/2017/06/15/135636
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    driver_path: "/usr/lib/chromium-browser/chromedriver",
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chrome_options: {
        args: %w(headless disable-gpu window-size=1680,1050),
      },
    )
  )
end

Capybara.javascript_driver = :selenium
