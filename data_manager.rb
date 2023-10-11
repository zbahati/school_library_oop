class DataManager
  def self.save_to_json(filename, data)
    File.write(filename, data.to_json)
  end

  def self.loaod_from_json(filename)
    if File.exist?(filename)
      JSON.parse(File.read(filename))
    else
      []
    end
  end
end
