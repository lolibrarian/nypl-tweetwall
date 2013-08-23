ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/mock'

class ActiveSupport::TestCase
  # Skips fetching remote images within the given +block+.
  def without_fetching_remote_images(&block)
    FastImage.stub(:size, [100, 150], &block)
  end
end
