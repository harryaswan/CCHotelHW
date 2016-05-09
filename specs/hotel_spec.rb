require('minitest/autorun')
require('minitest/rg')
require('colorize')
require_relative('../hotel')


class TestHotel < MiniTest::Test

    def setup()
        @hotel = Hotel.new("The Inn", 5, 10, :premium)
    end

    def test_hotel_has_a_name()
        test_result = @hotel.name
        expected_result = "The Inn"
        assert_equal(expected_result,test_result)
    end

    def test_hotel_has_a_type()
        test_result = @hotel.type
        expected_result = :premium
        assert_equal(expected_result,test_result)
    end


    def test_hotel_has_rooms()
        test_result = @hotel.total_rooms
        expected_result = 50
        assert_equal(expected_result, test_result)
    end

    def test_hotel_avaliable_rooms()
        test_result = @hotel.rooms_avaliable.length
        expected_result = 50
        assert_equal(expected_result,test_result)
    end

    def test_hotel_types_of_rooms_free()
        test_result = @hotel.room_types_avaliable
        expected_result = "Can't check due to random"
        assert_equal(expected_result,test_result)
    end

    def test_hotel_check_in()
        test_result = @hotel.check_in(103, "James Mcovoy", 1)
        expected_result = true
        assert_equal(expected_result, test_result)
    end

    def test_hotel_check_out()
        @hotel.check_in(103, "James Mcovoy", 1)
        @hotel.check_out(103)
        test_result = @hotel.rooms_avaliable.length
        expected_result = 50
        assert_equal(expected_result, test_result)
    end
end
