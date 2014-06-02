# CLI Server/Browser

A simple server to process requests and send responses, and a simple browser to issue requests (for Project 2 of The Odin Project's [Projects: Ruby on the Web](http://www.theodinproject.com/ruby-programming/ruby-on-the-web).)

You will need two terminals; in the first, run `ruby server.rb` and in the second, run `ruby browser.rb`

You may now issue a GET request or a POST request.  The server handles the GET request by simply looking for the requested file in it's directory and returning the file if found.
For a POST request, data about a viking is sent to the server who responds with a small HTML document that incorporates the viking's data sent to it in the POST request.

*You will have to shutdown the server with `Ctrl-C`.*
