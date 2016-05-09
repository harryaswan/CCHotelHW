require('minitest/autorun')
require('minitest/rg')
require('colorize')
require_relative('../guest')


class TestGuest < MiniTest::Test

    def setup()
        @guest = Guest.new("Brian Adams")
        @unnamed_guest = Guest.new()
    end

    def test_guest_has_name()
        test_result = @guest.name
        expected_result = "Brian Adams"
        assert_equal(expected_result,test_result)
    end

    def test_unnamed_guest_has_no_name()
        test_result = @unnamed_guest.name
        expected_result = "UNNAMED"
        assert_equal(expected_result,test_result)
    end

end
