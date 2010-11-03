require 'test_helper'
require 'rails/performance_test_help'

class Ads3Test < ActionDispatch::PerformanceTest
  # Replace this with your real tests.
  def test_serve
    get '/serve', {:pub => 'asdf', :tid => '1'}
  end
end
