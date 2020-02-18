class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files 
    Dir.chdir(@path) do |f|
      Dir.glob("*.mp3")
    end
  end
  
  def import
    files.each {|f| Song.create_from_filename(f)} 
  end
end
