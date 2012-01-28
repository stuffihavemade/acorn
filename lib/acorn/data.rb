module Acorn
  class Data
    attr_accessor :dir_name, :seed_names, :attr_names, :ar_class
    def initialize
      self.seed_names = []
      self.attr_names = []
    end
    def process
      DataProcessor.new(self).process
    end
  end
end
