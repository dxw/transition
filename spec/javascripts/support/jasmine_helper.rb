require "jasmine_selenium_runner/configure_jasmine"

class HeadlessChromeJasmineConfigurer < JasmineSeleniumRunner::ConfigureJasmine
  def selenium_options
    args = %w[no-sandbox disable-dev-shm-usage disable-gpu]
    options = Selenium::WebDriver::Chrome::Options.new(args: args)
    options.headless!
    { options: options }
  end
end
