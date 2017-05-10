require "sinatra"
require 'sinatra/base'
require "sinatra"
require 'pony'
require 'sendgrid-ruby'
include SendGrid



set :bind, '0.0.0.0'


get "/" do
  erb :index
end

post "/email" do
  unless params[:name] == "" || params[:email] == "" || params[:message] == ""
    Pony.mail({
      :to => 'chadd980@gmail.com',
      :from => "My portfolio <noreply@myapp.com>",
      :subject => "New message through your portfolio from #{params[:email]}",
      :body => "#{params[:name]} says: #{params[:message]}. respond using #{params[:email]}",
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :enable_starttls_auto => true,
        :user_name => 'apikey',
        :password => ENV['SENDGRID_API_KEY'],
        :authentication => :plain
        # :domain => "myapp.com"
      }
    })
  end
  redirect "/"
end
