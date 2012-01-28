$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'acorn'
require 'ruby-debug'

def reconnect
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => ':memory:',
    :pool     => 5,
    :timeout  => 5000)
    ActiveRecord::Schema.define do
      create_table :genders do |t|
        t.string :gender_column
      end
    end
    ActiveRecord::Schema.define do
      create_table :colors do |t|
        t.string :color
        t.string :short_color
      end
    end
end

class Gender < ActiveRecord::Base
end

class Color < ActiveRecord::Base
end

DirName = File.join(File.dirname(__FILE__), 'test_data/')

describe 'DataValidator' do
  it 'raises an error if the number of columns and seeds is not equal' do
    data = Acorn::Data.new
    data.attr_names = [1,2]
    data.seed_names  = [1]
    lambda {DataValidator.new(data).validate!}.should raise_error
  end
end

describe 'SeedGrabber' do
  it 'deserialzes json files into json data' do
    seed_grabber = Acorn::SeedGrabber.new DirName, [:genders, :sexual_preferences]
    genders = ['male', 'female']
    sexual_prefs = ['likes guys', 'likes girls', 'likes guys and girls']
    seed_grabber.grab.should eql [genders, sexual_prefs]
  end
end

describe 'ARFriendly' do
  it 'converts the incoming data into a form more suitable for active record' do
    colors = ['red', 'green', 'blue']
    short_colors = ['r', 'g', 'b']
    seeds = [colors, short_colors]

    attr_names = [:color_names, :short_color_names]
    ar_friendly = Acorn::ARFriendly.new attr_names, seeds
    expect = []
    expect << {:color_names => 'red', :short_color_names => 'r'}
    expect << {:color_names => 'green', :short_color_names => 'g'}
    expect << {:color_names => 'blue', :short_color_names => 'b'}
    ar_friendly.to_friendly.should eql expect
  end
end

describe 'DataProcessor' do
  before :each do 
    reconnect
  end

  it 'can process one seed collection and one column' do
    data = Acorn::Data.new
    data.dir_name = DirName
    data.seed_names = [:genders]
    data.attr_names = [:gender_column]
    data.ar_class = Gender

    data_processor = Acorn::DataProcessor.new data
    data_processor.process

    Gender.all.collect{|g| g.gender_column}.should eql ['male', 'female']
  end
  it 'can process two seed collections and two columns' do
    data = Acorn::Data.new
    data.dir_name = DirName
    data.seed_names = [:colors, :short_colors]
    data.attr_names = [:color, :short_color]
    data.ar_class = Color

    data_processor = Acorn::DataProcessor.new data
    data_processor.process

    Color.all.collect{|c| c.color}.should eql ['red', 'green', 'blue']
    Color.all.collect{|c| c.short_color}.should eql ['r', 'g', 'b']
  end
end

describe 'DSL' do
  before :each do 
    reconnect
  end
  it 'works' do
    Acorn::Use_seed_directory(DirName).
      Insert('genders').into_attr(:gender_column).of_AR_class(Gender).
      Insert('colors').and('short_colors').into_attr(:color).and_attr(:short_color).of_AR_class(Color)

    Gender.all.collect{|g| g.gender_column}.should eql ['male', 'female']
    Color.all.collect{|c| c.color}.should eql ['red', 'green', 'blue']
    Color.all.collect{|c| c.short_color}.should eql ['r', 'g', 'b']
  end
end
