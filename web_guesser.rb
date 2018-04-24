require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@message = ""
bg_colour = "none"
@@guesses = 5



def set_bg_colour
	case 
	when (@@message == "Way too high!" or @@message == "Way too low!") then "red"
	when (@@message == "Too high!" or @@message == "Too low!") then "LightPink"
	when @@message == "You got it right!</br></br> A new number has been generated" then "green"
	else "none"
	end
end

def check_guess(guess)
	@@guesses -= 1
	if guess.to_i == 0
		message = ""
	elsif guess.to_i > @@secret_number
		guess.to_i - @@secret_number > 5 ? "Way too high!" : "Too high!"
	elsif guess.to_i < @@secret_number
		@@secret_number - guess.to_i > 5 ? "Way too low!" : "Too low!"
	elsif guess.to_i == @@secret_number
		@@guesses = "x"
	end
end

def guess_0
	
	if @@guesses == 0 or @@guesses == "x"
		@@secret_number = rand(101)
		@@guesses == 0 ? @@message = "You ran out of guesses</br></br>A new number has been generated" : @@message = "You got it right the number was #{@@secret_number}!</br></br> A new number has been generated" 	
	  @@guesses = 5
	else ""
	end
end

def check_cheat
	@@message += " </br></br>SECRET: #{@@secret_number}" if params["cheat"] == "true"
end

get '/' do
	@@message = check_guess(params["guess"])
	guess_0
	bg_colour = set_bg_colour
	check_cheat
	erb :index, :locals => {:message => @@message, :bg_colour => bg_colour}
end