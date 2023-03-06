require "test_helper"

class DirectorTest < ActiveSupport::TestCase
  def setup
    @director = create(:director)
  end

  def test_successful_creation
    assert_equal "John Doe", @director.name
  end
end
