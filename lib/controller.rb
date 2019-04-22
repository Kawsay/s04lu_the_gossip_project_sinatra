require_relative 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end 

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossip/:id' do
    id = params["id"].to_i
    erb :show, locals: {gossip: Gossip.find(id), id: id}
  end

  get '/gossip/:id/edit' do
    id = params["id"].to_i
    erb :edit, locals: {gossip: Gossip.find(id), id: id}
  end

  post '/gossip/:id/edit' do
    id = params["id"].to_i
    puts id
    content = params["gossip_content"]
    author = params["gossip_author"]
    Gossip.edit(id, author, content)
    redirect '/'
  end
end