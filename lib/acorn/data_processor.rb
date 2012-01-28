module Acorn
  class DataProcessor
    attr_accessor :data
    def initialize data
      self.data = data
      self.data.attr_names.map! {|x| x.to_s}
      self.data.seed_names.map! {|x| x.to_s}
    end
    def process
      data = self.data
      DataValidator.new(data).validate!

      seed_grabber = SeedGrabber.new data.dir_name, data.seed_names
      seeds = seed_grabber.grab

      friendly = ARFriendly.new(data.attr_names, seeds).to_friendly
      friendly.each do |f|
        obj = data.ar_class.new
        f.each do |k,v|
          obj.send k.to_s + '=', v
        end
        obj.save!
      end
    end
  end
end
