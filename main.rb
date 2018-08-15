require 'sinatra'
require 'sinatra/reloader'

require './database'

%w[helpers models routes].each do |dir|
  #$LOAD_PATH << File.expand_path('.', File.join(File.dirname(__FILE__), dir))
  require_relative File.join(dir, 'init')
end


