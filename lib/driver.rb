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
    # apahotelの予約ページを開く
    @driver.navigate.to 'https://www.apahotel.com/hotel/shutoken/tokyo_makuhari_bay/'
    # calendar detailのデータを取得
    calendar = @driver.find_elements(:class, 'cl-detail')
    # nの値が"-"以外 ≒ 当月以外を取得
    calendar = calendar.map do |n|
      if n.text != '-'
        n.text
      end
    end
    # 取得が完了したらwebdriverを終了する
    dispose()
    # nilを消す
    calendar.compact!

    # 戻り値となるハッシュを用意
    calendar_data = Hash.new

    calendar.each_with_index do |n, i|
      # データを保存・・・なぜか2日からスタートなので+2。普段は+1でいいはず
      calendar_data.store(Date.new(2018, 12, i + 2).to_s, n)
    end
    calendar_data
  end

  def dispose()
    @driver.quit
    @driver = nil
  end

end
