require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name, :genre
  attr_reader :artist
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist.class == Artist && genre.class == Genre
      self.artist = artist
      self.genre = genre
    elsif artist.class == Artist && genre == nil
      self.artist = artist
    elsif artist == nil && genre != nil
      self.genre = genre
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name, artist = nil, genre = nil)
    song = self.new(name, artist, genre)
    self.all << song
    song
  end
  
  def self.find_or_create_by_name(name, artist = nil, genre = nil)
    if self.find_by_name(name) == nil
      self.create(name, artist, genre)
    else 
      self.find_by_name(name)
    end
  end      
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if genre.songs.include?(self) != true
      genre.songs << self
    end
  end
  
  def self.new_from_filename(file_name)
    name = file_name.split(" - ")[1]
    artist_string = file_name.split(" - ")[0]
    genre_string = file_name.split(" - ")[2].split(".")[0]
    artist = Artist.find_or_create_by_name(artist_string)
    genre = Genre.find_or_create_by_name(genre_string)
    self.find_or_create_by_name(name, artist, genre)
  end
  
  def self.create_from_filename(file_name)
    self.all << self.new_from_filename(file_name)
  end
end
