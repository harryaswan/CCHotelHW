require_relative("small_hotel")
require_relative("large_hotel")
class HotelChain

    attr_reader(:name)
    def initialize(name)
        @name = name
        @hotels = []
    end

    def create_small_hotel(name, type)
        return create_hotel(SmallHotel.new(name, type))
    end

    def create_large_hotel(name, type)
        return create_hotel(LargeHotel.new(name, type))
    end

    def create_hotel(hotel)
        if select_hotel(hotel.name)
            return nil
        else
            @hotels << hotel
            return hotel
        end
    end

    def check_in(hotel, number, name, others)
        selected = @hotels.index(select_hotel(hotel))
        if selected != nil
            return @hotels[selected].check_in(number, name, others)
        else
            return nil
        end
    end

    def check_out(hotel, number)
        selected = @hotels.index(select_hotel(hotel))
        if selected != nil
            return @hotels[selected].check_out(number)
        else
            return nil
        end
    end

    def guest_details(hotel, number)
        selected = @hotels.index(select_hotel(hotel))
        if selected != nil
            return @hotels[selected].guest_details(number)
        else
            return nil
        end
    end

    def rooms_avaliable(hotel)
        selected = @hotels.index(select_hotel(hotel))
        if selected != nil
            return @hotels[selected].rooms_avaliable
        else
            return nil
        end
    end

    def room_types_avaliable(hotel)
        selected = @hotels.index(select_hotel(hotel))
        if selected != nil
            return @hotels[selected].room_types_avaliable()
        else
            return nil
        end
    end

    def demolish(hotel)
        selected = @hotels.index(select_hotel(hotel))
        s_l = @hotels.length
        @hotels.delete_at(selected)
        if s_l-1 == @hotels.length
            return true
        else
            return false
        end
    end

    def list_hotels()
        hotel_names = []
        for h in @hotels
            hotel_names << h.name()
        end
        return hotel_names
    end

    def select_hotel(input)
        for h in @hotels
            if h.name == input
                return h
            end
        end
        return nil
    end
end
