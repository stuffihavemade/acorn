module Acorn
  class DataValidator
    attr_accessor :data
    def initialize data
      self.data = data
    end
    def validate! 
      if data.seed_names.length != data.attr_names.length
        raise 'There must be an equal number of seed names and column names defined.'
      end
    end
  end
end
