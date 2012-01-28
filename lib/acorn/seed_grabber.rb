module Acorn
  class SeedGrabber
    attr_accessor :dir_name, :seed_names
    def initialize dir_name, seed_names
      self.dir_name = dir_name
      self.seed_names = seed_names
    end

    def grab 
      seed_names.map do |seed_name|
        file_name = dir_name + seed_name.to_s + '.json'
        JSON.load open file_name
      end
    end
  end
end
