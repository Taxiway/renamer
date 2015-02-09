require_relative "name_pattern"

class Renamer

  @@dir = "Files/"

  def getFiles
    Dir.foreach(@@dir).to_a.delete_if do |f|
      f == "." || f == ".." || f == ".DS_Store"
    end
  end

  def rename(old, new)
    File.rename(@@dir + old, @@dir + new)
  end

  def run
    @files = getFiles

    puts "Input file name pattern:"
    pattern = gets().gsub("\n", '')
    @name_pattern = NamePattern.new(pattern, 1, @files.size, true)

    @files.each.zip(@name_pattern.each) do |file, name|
      #puts file + " -> " + name
      rename(file, name)
    end
  end

end

r = Renamer.new
r.run
