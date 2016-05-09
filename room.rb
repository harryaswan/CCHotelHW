class Room

    attr_reader(:number, :type, :sleeps)
    def initialize(rm_no, type)
        @number = rm_no
        @type = type
        @sleeps = get_sleeps(type)
        @guests = []
    end

    def floor
        t_f = @number
        while t_f > 0
            t_f -= 100
        end
        t_f += 100
        return ((@number - t_f)/100).to_i()
    end

    def guests
        return @guests.length
    end

    def guest_details
        if empty?
            return nil
        else
            return {lead: @guests[0].name, others: (@guests.length-1)}
        end
    end

    def check_in(guests)
        if guests.length <= @sleeps
            @guests = guests
            return true
        else
            return false
        end
    end

    def check_out()
        @guests = []
        if @guests.length <= 0
            return true
        else
            return false
        end
    end

    def empty?
        return @guests.empty?
    end

    def get_sleeps(type)
        pos_rooms = {
            budget_single: 1,
            budget_double: 2,
            budget_twin: 2,
            budget_family: 4,
            premium_single: 1,
            premium_double: 2,
            premium_twin: 2,
            premium_family: 4,
            penthouse_suite: 6
        }
        return pos_rooms[type]
    end

end
