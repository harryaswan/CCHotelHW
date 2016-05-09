require_relative('hotel')
class SmallHotel < Hotel

    def initialize(name, type)
        super(name, 2, 5, type)
    end

end
