require 'socket'
require 'json'

# Control the running of the elementary browser
def run_browser(host, port)
	while true
		display_menu
		choice = get_user_choice
		case choice
		when 1 then do_get(host, port)
		when 2 then do_post(host, port)
		when 3 then break
		end
	end
	puts "Closing browser...bye"
end

# Menu to run browser
def display_menu
	puts "Browser Menu"
	puts "============"
	puts "1. Make a GET request"
	puts "2. Make a POST request"
	puts "3. Exit"
end

# User choice for main browser menu
def get_user_choice
	while true
		choice = (prompt_and_get "Make a Selection (1 - 3): ").to_i
		return choice if choice.between?(1, 3)
	end
end

# Handle a user's get request
def do_get(host, port)
	filename = prompt_and_get "Enter name of file/resource to GET: "
	filename = "/#{ filename }" unless filename[0] == '/'
	make_request(host, port, :get, filename)
end

# Handle a user's post request
def do_post(host, port)
	body = get_viking_data.to_json
	headers = { "Content-Type" => "application/x-www-form-urlencoded",
	            "Content-Length" => body.length }
	make_request(host, port, :post, '/viking', headers, body)
end

# Get information from user for a viking and make viking hash
def get_viking_data
	puts "Register a viking for a raid..."
	name = (prompt_and_get "Enter viking's name: ").strip
	email = (prompt_and_get "Enter viking's email: ").strip
	{ viking: { name: name, email: email } }
end

# Get non-empty response from user to a prompt
def prompt_and_get prompt
	while true
		print prompt
		response = gets.chomp
		return response unless response == ""
	end
end

# Prepare and send a request to the server
def make_request(host, port, type, path, headers = nil, body = nil)
	request = generate_request(type, path, headers, body)
	socket = TCPSocket.open(host, port)
	socket.send(request, 0)

	response = socket.read
	display_response response
end

# Generate a HTTP request based on given parameters
def generate_request(type, path, headers, body)
	request = generate_initial_line(type, path)
	request += add_headers(headers) if headers
	request += "\r\n"
	request += body if body
	request
end

# Generate the headers portion of request
def add_headers headers
	headers_string = ""
	headers.each do |header_name, value|
		headers_string += header_name.to_s + ": " + value.to_s + "\r\n"
	end
	headers_string
end

# Generate the first line of the request
def generate_initial_line(type, path)
	initial_line = "GET " if type == :get
	initial_line = "POST " if type == :post 
	initial_line += path + " HTTP/1.0" + "\r\n"
end

# Show the body of response from the server
def display_response response
	headers, body = response.split("\r\n\r\n", 2)
  puts body
  print "\nPress Enter to continue..."; gets
end

# Set network parameters and run browser
host = 'localhost'
port = 1111
run_browser(host, port)
