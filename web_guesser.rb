require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
message = ""
@number = ""

def check_guess(guess)
	if guess.to_i > SECRET_NUMBER
		guess.to_i - SECRET_NUMBER > 5 ? "Way too high!" : "Too high!"
	elsif guess.to_i < SECRET_NUMBER
		SECRET_NUMBER - guess.to_i > 5 ? "Way too low!" : "Too low!"
	elsif guess.to_i == SECRET_NUMBER
		@number = "The SECRET NUMBER is #{SECRET_NUMBER}"		
		"You got it right\n"
	end
end

get '/' do
		message = check_guess(params["guess"])
		erb :index, :locals => {:message => message, :number => @number}
end