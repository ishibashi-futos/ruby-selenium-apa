require 'bundler/setup'
require 'selenium-webdriver'
require 'date'

# Use the Seleniumwebdriver to retrieve data.
class WebDriver
  def initialize()
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {
      binary: '/usr/bin/chromium-browser',
      args: [
        "--no-sandbox",
        "--headless",
        "--disable-gpu",
        "--window-size=320x240"
      ]
    })
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
  end

  def get_reservation_data()
    # open Booking page to apa hotel
    @driver.navigate.to 'https://www.apahotel.com/hotel/shutoken/tokyo_makuhari_bay/'
    # get calendar detail data
    calendar = @driver.find_elements(:class, 'cl-detail')
    # non "-"
    calendar = calendar.map do |n|
      if n.text != '-'
        n.text
      end
    end
    # dispose webdriver
    dispose()
    # compact array
    calendar.compact!

    # result hash data
    calendar_data = Hash.new

    calendar.each_with_index do |n, i|
      # save data
      calendar_data.store(Date.new(2018, 12, i + 2).to_s, n)
    end
    calendar_data
  end

  def dispose()
    @driver.quit
    @driver = nil
  end

end
