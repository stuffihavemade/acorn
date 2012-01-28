require 'json'
require 'active_record'

require 'acorn/ar_friendly'
require 'acorn/data'
require 'acorn/data_processor'
require 'acorn/data_validator'
require 'acorn/dsl'
require 'acorn/seed_grabber'
require 'acorn/version'

module Acorn
  def self.use_seed_directory dir_name
    First.new dir_name
  end

  def self.Use_seed_directory dir_name
    use_seed_directory dir_name
  end

#  end
end
