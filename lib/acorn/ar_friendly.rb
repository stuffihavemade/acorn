module Acorn
  class ARFriendly
    attr_accessor :column_names, :seeds
    #takes something like [:col1, :col2] [[:a,:b],[:c,:d]]
    #to [{:col1 => :a, :col2 => :c}, {:col1 => :b, :col2 => :d}]
    def initialize column_names, seeds
      self.column_names = column_names
      self.seeds = seeds
    end
    def to_friendly
      #seeds is like [[:a,:b,:c],[:d,:e,:f]]
      first = self.seeds[0]
      rest = self.seeds.drop 1
      #zipped is like [[:a,:d],[:b,:e],[:c,:f]]
      zipped = first.zip(*rest)
      zipped.map do |z|
        hash = {}
        self.column_names.zip(z).each do |zz|
          hash[zz[0].to_sym] = zz[1]
        end
        hash
      end
    end
  end
end
