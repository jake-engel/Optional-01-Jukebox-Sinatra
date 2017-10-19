require "sinatra"
require "sinatra/reloader" if development?
require "sqlite3"

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jukebox.sqlite'))

get "/" do
  # TODO: Gather all artists to be displayed on home page
  @artists = DB.execute(%(SELECT ar.name FROM artists ar)).flatten!.uniq.sort
  #@artists.each { |artist| params[:artist]}
  erb :home # Will render views/home.erb file (embedded in layout.erb)
end

get "/:name" do
  @name = params[:name]
  @albums = DB.execute(%(SELECT al.title FROM albums al)).flatten!.uniq.sort
  erb :artists
end

get "/:name/:album" do
  @album = params[:album]
  @tracks = DB.execute(%(SELECT tr.name FROM tracks tr)).flatten!.uniq.sort
  erb :tracks
end


# Then:
# 1. Create an artist page with all the albums. Display genres as well
# 2. Create an album pages with all the tracks
# 3. Create a track page with all the track info
