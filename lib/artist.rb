class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    artist = self.new(name)
    self.all << artist
    artist
  end
  
  def add_song(song)
    if song.artist == nil   
      song.artist = self
    end
    if @songs.include?(song) != true
      self.songs << song
    end
  end
  
  def genres
    self.songs.map{|song| song.genre}.uniq
  end
end