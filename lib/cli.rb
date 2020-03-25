require 'pry'
class CommandLineInterface
    
    def greet
        puts "Welcome to Spotify"
        puts "please enter a number to navigate"
    end


    def show_logo
   puts " 
   /$$$$$$                        /$$     /$$  /$$$$$$          
   /$$__  $$                      | $$    |__/ /$$__  $$         
  | $$  \\__/  /$$$$$$   /$$$$$$  /$$$$$$   /$$| $$  \\__//$$   /$$
  |  $$$$$$  /$$__  $$ /$$__  $$|_  $$_/  | $$| $$$$   | $$  | $$
   \\____  $$| $$  \\ $$| $$  \\ $$  | $$    | $$| $$_/   | $$  | $$
   /$$  \\ $$| $$  | $$| $$  | $$  | $$ /$$| $$| $$     | $$  | $$
  |  $$$$$$/| $$$$$$$/|  $$$$$$/  |  $$$$/| $$| $$     |  $$$$$$$
   \\______/ | $$____/  \\______/    \\___/  |__/|__/      \\____  $$
            | $$                                        /$$  | $$
            | $$                                       |  $$$$$$/
            |__/                                        \\______/ "              
   
    end 
    def prompt(string,array)
        prompt = TTY::Prompt.new
        prompt.select(string,array)
    end
    
    def display_menu
        menu = ["To play a song by name","To view all artists", "To view all songs by artist", "To view all songs by album", "To view all artists by genre", "To see all songs","To Exit" ]
        user_choice = prompt("Select a menu item please: ", menu)
        return user_choice
        binding.pry
        # puts "6. to make your own playlist"
    end

    def play # needs validation for when song does't exist in library
        puts "Enter the song name: "
        song = get_user_input.titleize
        song_instance = Song.find_by(name: song)
        puts "Playing #{song_instance.name}"
    end

    def view_all_artists
        puts "Artists: "
        count = 1
        Artist.all.each{|artist| ap "#{count}. #{artist.name}"
        count += 1
    }
    end
 

    def view_artists_songs
        artist_names = Artist.all.map{|artist| artist.name}
        artist_name = prompt("Select an artist name", artist_names.sort)
        artist_id = Artist.find_by(name: artist_name).id
        songs = Song.where(artist_id: artist_id)
        count = 1
        puts "**************************"
        puts "#{artist_name}'s songs"
        puts "**************************"
         final_answer = songs.each{|song| ap "#{count}. #{song.name}"
         count += 1
        }
    end



    def view_album_songs
        prompt = TTY::Prompt.new

        puts "Enter the album's title: "
        album_title = get_user_input.titleize
        album_id = Album.all.find_by(title: album_title).id
        songs = Song.where(album_id: album_id)
       
        puts "**************************"
        puts "#{album_title}"
        puts "**************************"
        count = 1
        songs.each do |song|
            ap "#{count}. #{song.name}" 
            count += 1
        end
    end

    def artist_by_genre 
        all_genres = Artist.all.map{|artist| artist.genre}.uniq.sort
        genre_name = prompt("Enter the genre's name: ", all_genres)
        artists = Artist.all.where(genre: genre_name)
        puts "**************************"
        puts "For #{genre_name}"
        puts "**************************"
        count = 1
        artists.each do |artist|
            ap "#{count}. #{artist.name}" 
            count += 1
        end
    end

    def make_your_own_playlist
        puts "Enter your album's name: "
        album_name = gets.chomp
        Album.create(name: album_name)
        puts "Which songs do you want to add to your playlist?"
        display_all_songs

    end 

    def display_all_songs
        Song.all.each{|song| puts "-#{song.name}"}
    end

    

    def get_user_input
        gets.chomp
    end

    def welcome 
        greet
        show_logo
    end

    # NEW ******************
    def exit_program
        puts "Goodbye!!!"
    end
     
    # # NEW ******************
    # def help
    #     puts "I accept the following commands:"
    #     puts "- Menu"
    #     puts "- Help"
    #     puts "- Search"
    #     puts "- Exit"
    # end

    
    # def run
    #     menu_array = ["To play a song by name","To view all artists", "To view all songs by artist", "To view all songs by album", "To view all artists by genre", "To see all songs" ]

    #     choice = display_menu
    #     if choice == menu_array[0]
    #         play
    #     elsif choice == menu_array[1]
    #         view_all_artists  
    #     elsif choice == menu_array[2]
    #         view_artists_songs
    #     elsif choice == menu_array[3]
    #         view_album_songs
    #     elsif choice == menu_array[4]
    #         artist_by_genre
    #     # elsif choice == 6
    #     #     make_your_own_playlist
    #     elsif choice == menu_array[5]
    #         display_all_songs
    #     end
    
    #     # prompt = TTY::Prompt.new
    #     # prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
    # end
    def run
        menu_array = ["To play a song by name","To view all artists", "To view all songs by artist", "To view all songs by album", "To view all artists by genre", "To see all songs","To Exit" ]
          
            input = ""
            while input
              puts "Please choose a command:"
              choice = display_menu
              case choice
              when menu_array[0]
                play
              when menu_array[1]
              when menu_array[2]
              when menu_array[3]
              when menu_array[4]
              when menu_array[5]
              when menu_array[6] #EXIT
                exit_program
                break
              else
                display_menu
              end
            end

    end


end


