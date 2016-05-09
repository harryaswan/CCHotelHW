require('minitest/autorun')
require('minitest/rg')
require('colorize')
require_relative('../room')
require_relative('../guest')


class TestRoom < MiniTest::Test

    def setup()
        @double_room = Room.new(151, :budget_double)
        @pent_room = Room.new(153, :penthouse_suite)
        @lead_guest = Guest.new("Johnny Cash")
        @other_guest = Guest.new()
    end

    def test_room_has_number()
        test_result = @double_room.number
        expected_result = 151
        assert_equal(expected_result,test_result)
    end

    def test_room_has_floor()
        test_result = @double_room.floor
        expected_result = 1
        assert_equal(expected_result,test_result)
    end

    def test_room_type()
        test_result = @double_room.type
        expected_result = :budget_double
        assert_equal(expected_result,test_result)
    end
    def test_room_number_room_sleeps()
        test_result = @double_room.sleeps
        expected_result = 2
        assert_equal(expected_result,test_result)
    end
    def test_room_number_room_sleeps_again()
        test_result = @pent_room.sleeps
        expected_result = 6
        assert_equal(expected_result,test_result)
    end
    def test_room_is_empty()
        test_result = @double_room.empty?
        expected_result = true
        assert_equal(expected_result,test_result)
    end
    def test_room_guests_in_room()
        test_result = @double_room.guests
        expected_result = 0
        assert_equal(expected_result,test_result)
    end
    def test_room_check_in()
        guests = [@lead_guest, @other_guest]
        @double_room.check_in(guests)
        test_result = @double_room.guests
        expected_result = 2
        assert_equal(expected_result,test_result)
    end
    def test_room_get_guest_details
        guests = [@lead_guest, @other_guest]
        @double_room.check_in(guests)
        test_result = @double_room.guest_details
        expected_result = {lead: "Johnny Cash", others: 1}
        assert_equal(expected_result,test_result)
    end
    def test_room_check_out()
        guests = [@lead_guest, @other_guest]
        @double_room.check_in(guests)
        @double_room.check_out
        test_result = @double_room.guests
        expected_result = 0
        assert_equal(expected_result,test_result)
    end
end
