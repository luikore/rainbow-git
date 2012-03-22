require "rubygems"
require "bundler"

# require "bundle gems"
ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

# init database
require_relative "database"

# init sinatra
set :sessions, true
set :root, File.expand_path(".")
set :views, settings.root + "/app/views"
disable :protection

# sinatra reloader on development
if ENV["RACK_ENV"] == "development"
  require "sinatra/reloader"
end

# assetpack support
assets do
  css_compression :sass
  js_compression  :uglify

  serve "/js", :from => "app/assets/js"
  serve "/css", :from => "app/assets/css"
  serve "/img", :from => "app/assets/img"

  js :application, [
    "/js/*.js"
  ]

  css :application, [
    "/css/*.css"
  ]
end

# require project
Dir.glob "./{lib,app/models,app/helpers,app/controllers}/**/*.rb" do |f|
  require f
end
use Rack::XProtection
