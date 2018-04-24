require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@message = ""
number = ""
bg_colour = "none"
@@guesses = 5

def set_number
	"The secretT NUMBER is #{@@secret_number}" if @@message == "You got it right"  
end

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
	if guess == ""
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
		@@guesses == 0 ? @@message = "You ran out of guesses</br></br>A new number has been generated" : @@message = "You got it right!</br></br> A new number has been generated" 	
	  @@guesses = 5
	else ""
	end
end

get '/' do
	@@message = check_guess(params["guess"])
	number = set_number
	guess_0
	bg_colour = set_bg_colour
	erb :index, :locals => {:message => @@message, :number => number, :bg_colour => bg_colour}
end