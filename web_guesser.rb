require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

message = ""
number = ""
bg_colour = "none"

def set_number(message)
	"The SECRET NUMBER is #{SECRET_NUMBER}" if message == "You got it right"  
end

def set_bg_colour(message)
	case 
	when (message == "Way too high!" or message == "Way too low!") then "red"
	when (message == "Too high!" or message == "Too low!") then "LightPink"
	when message == "You got it right!" then "green"
	else "none"
	end
end

def check_guess(guess)
	
	if guess.to_i > SECRET_NUMBER
		guess.to_i - SECRET_NUMBER > 5 ? "Way too high!" : "Too high!"
	elsif guess.to_i < SECRET_NUMBER
		SECRET_NUMBER - guess.to_i > 5 ? "Way too low!" : "Too low!"
	elsif guess.to_i == SECRET_NUMBER
		"You got it right!"
	end
end

get '/' do
		message = check_guess(params["guess"])
		number = set_number(message)
		bg_colour = set_bg_colour(message)
		erb :index, :locals => {:message => message, :number => number, :bg_colour => bg_colour}
end