require_relative('room')
require_relative('guest')

class Hotel

    attr_reader(:name, :total_rooms, :type)
    def initialize(name, floors, rooms, type)
        @name = name
        @total_rooms = (floors*rooms)
        @type = type
        @rooms = create_rooms(floors, rooms, type)
    end

    def rooms_avaliable
        free_rooms = @rooms.select { |r| r.empty? }
        rooms = []
        for fr in free_rooms
            rooms << {number: fr.number, type: fr.type, sleeps: fr.sleeps}
        end
        return rooms
    end

    def room_types_avaliable
        rooms = @rooms.select {|r| r.type if r.empty? }
        grouped = rooms.group_by {|i| i.type}
        return grouped.keys.map {|i| [i, grouped[i].length] }
    end

    def get_room(n)
        return @rooms.index {|r| r.number == n}
    end

    def check_in(rm_nbr, lead_guest, others)
        guests = []
        guests << Guest.new(lead_guest)
        others.times { guests << Guest.new() }
        if get_room(rm_nbr)
            return @rooms[get_room(rm_nbr)].check_in(guests)
        else
            return false
        end
    end

    def check_out(rm_nbr)
        return @rooms[get_room(rm_nbr)].check_out()
    end

    def guest_details(number)
        return @rooms[get_room(number)].guest_details()
    end

    def create_rooms(floors, rooms, type)
        room_arr = []
        types = {
            budget: [:budget_single, :budget_double, :budget_twin, :budget_family],
            premium: [:premium_single, :premium_double, :premium_twin, :premium_family]
        }
        for f in (1..floors)
            for r in (1..rooms)
                t_f = f*100
                t_r = t_f+r
                t_t = types[type][rand(0..3)]
                room_arr << Room.new(t_r, t_t)
            end
        end

        return room_arr
    end


end
