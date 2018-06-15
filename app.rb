require "sinatra/base"
require_relative "commands"

class App < Sinatra::Base
  set :erb, :escape_html => true

  def title
    "My App"
  end

  get "/" do
    redirect url("/processes")
  end

  get "/processes" do
    if params[:sort]
      key, order = key.split(":")
    else
      key, order = nil, nil
    end
    
    if params[:user]
      user = params[:user]
    else
      user = nil
    end
    
    @output = Commands.processes(user, key, order)
    
    erb :processes
  end
  
  get "/find_user" do
    erb :find_user
  end
  
  get "/man" do
    @output = `man ps`.split("\n")
    erb :man
  end
  
  get "/index" do
    erb :index
  end
  
  get "/test" do
    "yo world"
  end
  
end
