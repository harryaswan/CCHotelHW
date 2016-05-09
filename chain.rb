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
        return selected != nil ? @hotels[selected].check_in(number, name, others) : nil
    end

    def check_out(hotel, number)
        selected = @hotels.index(select_hotel(hotel))
        return selected != nil ? @hotels[selected].check_out(number) : nil
    end

    def guest_details(hotel, number)
        selected = @hotels.index(select_hotel(hotel))
        return selected != nil ? @hotels[selected].guest_details(number) : nil
    end

    def rooms_avaliable(hotel)
        selected = @hotels.index(select_hotel(hotel))
        return selected != nil ? @hotels[selected].rooms_avaliable : nil
    end

    def room_types_avaliable(hotel)
        selected = @hotels.index(select_hotel(hotel))
        return selected != nil ? @hotels[selected].room_types_avaliable() : nil
    end

    def demolish(hotel)
        selected = @hotels.index(select_hotel(hotel))
        s_l = @hotels.length
        @hotels.delete_at(selected)
        return s_l-1 == @hotels.length ? true : false
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
            return h if h.name == input
        end
        return nil
    end
end
