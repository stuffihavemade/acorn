module Acorn
  class First
    attr_accessor :data
    def initialize dir_name
      self.data = Data.new
      self.data.dir_name = dir_name
    end

    def insert seed_name
      self.data.seed_names << seed_name
      Second.new self.data
    end
    def Insert seed_name
      insert seed_name
    end
  end

  class Second
    attr_accessor :data

    def initialize data
      self.data = data
    end

    def and seed_name
      self.data.seed_names << seed_name
      self
    end

    def into_attr attr_name
      self.data.attr_names << attr_name
      Third.new self.data 
    end
  end

  class Third
    attr_accessor :data

    def initialize data
      self.data = data
    end

    def and_attr attr_name
      self.data.attr_names << attr_name
      self
    end

    def of_AR_class ar_class
      self.data.ar_class = ar_class
      self.data.process
      First.new self.data.dir_name
    end
  end
end
