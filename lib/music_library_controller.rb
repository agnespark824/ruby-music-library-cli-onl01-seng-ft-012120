require 'pry'

class MusicLibraryController
  attr_accessor :path
  attr_reader :music_importer, :imported_array
  
  def initialize(path = "./db/mp3s")
    @path = path
    @music_importer = MusicImporter.new(path)
    @music_importer.import
    @imported_array = []
    @imported_array << @music_importer.import.map do |f| 
      Song.create_from_filename(f)
    end
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    command = gets.chomp
    until command == "exit"
      self.call
    end
  end
  
  def list_songs
    counter = 1
    @imported_array.each do |a| 
      a.sort_by{|s| s.name}.map do |i|
        puts "#{counter}. #{i.artist} - #{i.name} - #{i.genre}"
        counter += 1
      end
    end
  end
  
  def list_artists
    counter = 1
    @imported_array.sort_by{|f| f.artist.name}.map do |f|
      puts "#{counter}. #{f.artist.name}"
      counter += 1
    end
  end
  
  def list_genres
    counter = 1
    @songs = []
    @imported_array.sort_by{|f| f.genre.name}.map do |f|
      puts "#{counter}. #{genre}"
      counter += 1
    end
  end
  
  def list_songs_by_artist
    
  end
  
end