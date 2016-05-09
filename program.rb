require_relative('chain')
class HotelProgram

    def initialize()
        @running = true
        @chain = nil
        @selected_hotel = nil
    end

    def get_user_input()
        print " > "
        return gets.chomp
    end

    def start
        cmd_show_help()
        while @running
            u_string = get_user_input()
            run_command(u_string)
        end
    end

    def run_command(cmd)
        case(cmd)
        when "help", "h"
            cmd_show_help()
        when "create chain", "cc"
            cmd_create_chain()
        when "chain bust", "cb"
            cmd_chain_gone_bust()
        when "create hotel", "ch"
            cmd_create_hotel()
        when "demolish hotel", "dh"
            cmd_demolish_hotel()
        when "list hotels", "lh"
            cmd_list_hotels()
        when "select hotel", "sh"
            cmd_select_hotel()
        when "view selected hotel", "vsh", "vs"
            cmd_view_selected_hotel()
        when "check in", "ci"
            cmd_check_in()
        when "check out", "co"
            cmd_check_out()
        when "guest details", "gd"
            cmd_guest_details()
        when "rooms avaliable", "ra"
            cmd_rooms_avaliable()
        when "room types avaliable", "rta"
            cmd_room_types_avaliable()
        when "exit", "q"
            close()
        else
            puts "Sorry, \"#{cmd}\" is not a recognised command."
        end
    end

    def cmd_create_chain()
        if @chain
            puts "A chain called '#{@chain.name}' already exists..."
        else
            puts "Please enter the name of your Hotel Chain: "
            input = gets.chomp
            @chain = HotelChain.new(input)
            if @chain
                puts "'#{@chain.name}' has been created..."
            end
        end
    end

    def cmd_chain_gone_bust()
        if @chain
            puts "Are you sure? This will delete all your hotels?\n"
            input = ""
            while input != "Y" && input != "N"
                print "(Y/N):"
                input = gets.chomp
            end
            if input == "Y"
                puts "Bye bye #{@chain.name}..."
                @chain = nil

            else
                puts "The chain is saved....\n\n\nfor now....."
            end
        else
            puts "Good news... you can't go bust if you ain't open!"
        end
    end

    def cmd_create_hotel()
        if @chain
            @selected_hotel = nil
            puts "Small or Large hotel?"
            size = ""
            while size != "small" && size != "large"
                print "(small/large): "
                size = gets.chomp.downcase()
                if size == "small"
                    name = ""
                    type = ""
                    while name == "" || type == ""
                        print "Name: "
                        name = gets.chomp
                        print "Type: "
                        type = gets.chomp
                        if type != "budget" && type != "premium"
                            type = ""
                        end
                    end
                    @selected_hotel = @chain.create_small_hotel(name, type.to_sym)
                elsif size == "large"
                    name = ""
                    type = ""
                    while name == "" || type == ""
                        print "Name: "
                        name = gets.chomp
                        print "Type: "
                        type = gets.chomp
                        if type != "budget" && type != "premium"
                            type = ""
                        end
                    end
                    @selected_hotel = @chain.create_large_hotel(name, type.to_sym)
                end
                if @selected_hotel
                    puts "'#{@selected_hotel.name}'' has been created and has been selected"
                else
                    puts "Check that the hotel name that you entered is unique, nothing has been created..."
                end
            end
        else
            puts "You must first create a hotel chain."
        end

    end

    def cmd_list_hotels()
        if @chain
            for h in @chain.list_hotels()
                puts "-> #{h}"
            end
        else
            puts "No chain exists, therefore no hotels exist..."
        end
    end

    def cmd_view_selected_hotel()
        if @selected_hotel
            puts "''#{@selected_hotel.name}' is currently selected"
        else
            puts "No hotel is currently selected"
        end
    end

    def cmd_demolish_hotel()
        if @chain
            if @selected_hotel
                puts "'#{@selected_hotel.name}' is currently selected"
                puts "If you would like to demolish it, type DELETE"
                puts "or type anything else to exit this menu..."
                input = gets.chomp
                if input == "DELETE"
                    @chain.demolish(@selected_hotel.name)
                    puts "And it's gone!"
                else
                    puts "Don't worry, nothing has been destroyed :)"
                end
            else
                puts "To demolish a hotel you must first select a hotel..."
                while !@selected_hotel
                    cmd_select_hotel()
                end
                puts "Now that you have a selected hotel, confirm you wish to demolish it\nby typing in DELETE now..."
                input = gets.chomp
                if input == "DELETE"
                    @chain.demolish(@selected_hotel)
                    @selected_hotel = nil
                    puts "And it's gone!"
                else
                    puts "Don't worry, nothing has been destroyed :)"
                end
            end
        else
            puts "You can't demolish hotels in a chain that doesn't exist..."
        end
    end

    def cmd_select_hotel()
        if @chain
            puts "To select a hotel you must type out it's name exactly..."
            puts "If you are unsure of the names, type LIST to display them here..."
            exit_select = false
            while !exit_select
                puts ":>"
                input = gets.chomp
                if input == "LIST"
                    cmd_list_hotels()
                else
                    @selected_hotel = @chain.select_hotel(input)
                    puts "#{@selected_hotel.name} is now selected..." if @selected_hotel
                    exit_select = true
                end
            end
        else
            puts "No chain exists, so there are no hotels to select..."
        end
    end

    def cmd_check_in()
        if @chain
            if @selected_hotel
                guest = ""
                puts "Please enter the name of the lead guest:"
                while guest == ""
                    print "Guest Name: "
                    guest = gets.chomp
                end
                number = 0
                while number == 0
                    print "Room number: "
                    number = gets.chomp.to_i()
                end
                print "Number of other guests: "
                others = gets.chomp.to_i()
                if @chain.check_in(@selected_hotel.name, number, guest, others)
                    puts "#{guest} has now been checked into room #{number}"
                else
                    puts "There was an error during check in. Please ensure:"
                    puts "    - The room can sleep the number of guests"
                    puts "    - The room is not already occupied"
                    puts "    - The room number entered is valid"
                end
            else
                puts "No hotel has been selected so we can't check anyone in..."
            end
        else
            puts "No chain has been created so there are no hotels to check anyone into..."
        end


    end

    def cmd_check_out()
        if @chain
            if @selected_hotel
                puts "Please enter the room number you wish to check out:"
                number = 0
                while number == 0
                    print "Room number: "
                    number = gets.chomp.to_i()
                end
                if @chain.check_out(@selected_hotel.name, number)
                    puts "Room #{number} has been checked out..."
                else
                    puts "There was an error, perhaps the room number you entered was already empty?"
                end
            else
                puts "No hotel has been selected so we can't check anyone out..."
            end
        else
            puts "No chain has been created so there are no hotels.... so no guests either..."
        end
    end

    def cmd_guest_details()
        if @chain
            if @selected_hotel
                puts "Please enter the room number you wish to enquire about:"
                number = 0
                while number == 0
                    print "Room number: "
                    number = gets.chomp.to_i()
                end
                details = @chain.guest_details(@selected_hotel.name, number)
                if details != nil
                    puts "Details for room #{number}:"
                    puts "    - Lead Guest: #{details[:lead]}"
                    puts "    - Others staying: #{details[:others]}"
                else
                    puts "No one is currently stayng in this room"
                end
            else
                puts "You must first select a hotel...."
            end
        else
            puts "No chain has been created, so there are no hotels... so no guests either..."
        end
    end

    def cmd_rooms_avaliable()
        if @chain
            if @selected_hotel
                rooms = @chain.rooms_avaliable(@selected_hotel.name)
                puts "| Number | Type            | Sleeps |"
                for r in rooms
                    number = "#{r[:number]}"
                    type =  "#{r[:type]}"
                    sleeps = "#{r[:sleeps]}"
                    number << " "*(6 - number.length) if 6 - number.length> 0
                    type << " "*(15 - type.length) if 15 - type.length > 0
                    puts "-"*37
                    puts "| #{number} | #{type} | #{sleeps}      |"
                end
            else
                puts "You must first select a hotel..."
            end
        else
            puts "No chain exists... No chain = No Hotel = No Rooms..."
        end
    end

    def cmd_room_types_avaliable()
        if @chain
            if @selected_hotel
                rooms = @chain.room_types_avaliable(@selected_hotel.name)
                puts "| Type            | Number avaliable |"
                for r in rooms
                    type = r[0].to_s()
                    number = r[1].to_s()
                    type << " "*(15-type.length) if 15 - type.length > 0
                    number << " "*(16-number.length) if 16 - number.length > 0
                    puts "-"*38
                    puts "| #{type} | #{number} |"
                end
            else
                puts "You must first select a hotel..."
            end
        else
            puts "No chain exists... No chain = No Hotel = No Rooms..."
        end
    end

    def cmd_show_help()

        print "\n\nHotelMaster v1.1\n\n"


        puts "help | h                      : prints out this help menu"
        puts "create chain | cc             : creates a new hotel chain - required for any hotels"
        puts "chain bust | cb               : your chain has gone bust - this will delete the chain and all hotels"
        puts "create hotel | ch             : creates a new hotel in your chain"
        puts "demolish hotel | dh           : destroys the currently seleted hotel and all of it's information"
        puts "list hotel | lh               : list all the hotels that have been created"
        puts "select hotel | sh             : allows you to select a hotel to preform actions on"
        puts "view selected hotel | vsh     : displays the name of the hotel currently selected"
        puts "check in | ci                 : allows you to check a guest into a room within the currently selected hotel"
        puts "check out | co                : allows you to check out a guest from a room within the current hotel"
        puts "guest details | gd            : displays the details of the guests staying in a paticular room in the current hotel"
        puts "rooms avaliable | ra          : displays all the rooms that are avaliable and their types within the current hotel"
        puts "room types avaliable | rta    : displays the types of rooms avaliable and the number of them"
        puts "exit | q                      : exits the program - everything will be destroyed"

        print "\n\n"

    end

    def close()
        puts "here"
        @running = false
    end
end
con = HotelProgram.new()
con.start()
