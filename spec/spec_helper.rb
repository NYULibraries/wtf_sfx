# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  config.around(:example) do |example|
    # failed = false
    # until failed
    #   example.run rescue failed = true
    # end
    # 2.times { example.run }
  end
end
# Use Capybara and Selenium
require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist

# Some common contants and methods
module WtfSfx
  require 'yaml'
  require 'pry'

  URL = "http://sfx.library.nyu.edu/sfxlcl41"
  API_URL = "#{URL}?sfx.response_type=multi_obj_xml"

  def self.pmids
    @pmids ||= fixtures["pmids"]
  end

  def self.fixtures
    @fixtures ||= YAML.load_file("#{File.dirname(__FILE__)}/support/fixtures.yml")
  end
end
