require 'socket'
require 'json'

# Determine type of request received and handle it
def handle_request request
	method_verb, resource_path = get_verb_and_path request
	case method_verb
	when 'GET' then handle_GET resource_path
	when 'POST' then handle_POST request 
	else handle_bad_request method_verb
	end
end

# Handle a GET request
def handle_GET resource_path
	resource_path = resource_path[1..-1] if resource_path[0] == '/'

	if File.exist?(resource_path)
		create_found_response(resource_path)
	else
		create_not_found_response(resource_path)
	end
end

# Handle a POST request
def handle_POST request
	head, body = head_body_split request
	params = JSON.parse body
	contents = File.read "thanks.html"
	contents = modify_content(contents, params["viking"])
	create_response(200, "OK", contents)
end

# Handle an unknown request
def handle_bad_request method_verb
	body = "Do not recognize the '#{method_verb}' request"
	create_response(400, "Bad Request", body)
end

# Substitute the "<%= yield %>" line of file with a viking's information
def modify_content(contents, viking_data)
	target = "<%= yield %>"
	target_line = contents.split("\n").find { |line| line.include?(target) }
	insert_string = ""
	viking_data.each do |key, value| 
		insert_string += target_line.sub(target, "<li>#{ key }: #{ value }</li>\n")
	end
	contents.sub(target_line, insert_string.chomp)
end

# Create response when requested file is found
def create_found_response resource_path
	contents = File.read(resource_path)
	create_response(200, "OK", contents)
end

# Create response when requested file is not found
def create_not_found_response resource_path
	contents = "File not found: Could not find the file '#{resource_path}'"
	create_response(404, "Not Found", contents)
end

# Generic method to create a valid HTTP response based on parameters
def create_response code, reason, contents
	size = contents.size
	generate_response({ code: code, reason: reason,
	                   headers: { "Content-Type" => "text/html",
	                              "Content-Length" => size },
	                   body: contents })
end

# Assemble various parts of response into a valid response
def generate_response res_parts
	version = "HTTP/1.1"
	response = version + " #{ res_parts[:code] } " + res_parts[:reason] + "\r\n"
	res_parts[:headers].each do |header_name, value|
		response += header_name.to_s + ": " + value.to_s + "\r\n"
	end
	response += "\r\n" + res_parts[:body]
end

# Split the first line of a request into the request verb and path
def get_verb_and_path request
	initial, headers = initial_headers_split request
	verb, path = initial.split(" ")[0..1]
end

# Split request in to the head and body sections
def head_body_split request
	head, body = if request.include?("\r\n\r\n")
		             request.split("\r\n\r\n", 2)
		           else
		             request.split("\n\n", 2)
		           end
end

# Split the head of request into its first line and headers
def initial_headers_split request
	head, body = head_body_split request
	initial, headers = if head.include?("\r\n")
		                   head.split("\r\n", 2)
		                 else
		                 	 head.split("\n", 2)
		                 end
end

server = TCPServer.open(1111)

# Start running the server and handle connections from clients
loop do
	Thread.start(server.accept) do |client|
    request  = client.recv(1000)
		response = handle_request request
		client.puts response

		client.close
	end
end
