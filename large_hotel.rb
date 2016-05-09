require_relative('hotel')
class LargeHotel < Hotel

    def initialize(name, type)
        super(name, 10, 10, type)
    end

end
