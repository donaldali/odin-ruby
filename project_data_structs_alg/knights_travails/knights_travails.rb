PositionPath = Struct.new(:position, :path)

# Find shortest knight path between two chess board positions
def knight_moves(from, to)
	return unless input_valid?(from, to)
	path = knight_path(from, to)
	display_path path
end

# Find a shortest path a knight can take between two positions on a chess board
def knight_path(from, to)
	open_queue = [PositionPath.new( from, [copy(from)] )]
	discovered = [from]

	until open_queue.empty?
		current = open_queue.shift

		return current.path if current.position == to
		valid_moves(current.position).each do |move|
			unless discovered.include?(move)
				discovered << move
				open_queue.push(make_position_path(current, move)) 
			end
		end
	end
	
end

# Create a PositionPath struct to hold a position and the path to that position
def make_position_path(current, new_position)
	new_path = copy(current.path + [new_position])
	PositionPath.new(new_position, new_path) 
end

# Determine all valid position a knight can move to from a given position
def valid_moves(from)
	possible_moves(from).select { |move| valid_position?(move) }
end

# Generate all possible knight moves (legal and illegal)
def possible_moves(from)
	positions = []
	pair = { 1 => [2, -2], 2 => [1, -1] }
  row_change = [-2, -1, 1, 2]
  row_change.each do |change|
  	positions << add_positions(from, [change, pair[change.abs][0]])
  	positions << add_positions(from, [change, pair[change.abs][1]])
  end
	positions
end

# Add row and column segments of two positions
def add_positions(pos1, pos2)
	[pos1[0] + pos2[0], pos1[1] + pos2[1]]
end

# Ascertain if a position is legal on a chess board
def valid_position?(position)
	board_size = 8
	position[0].between?(0, board_size - 1) && position[1].between?(0, board_size - 1)
end

# Ascertain the validity two inputted positions
def input_valid?(from, to)
	valid_position?(from) && valid_position?(to)
end

# Make a deep copy of an object (used on nested arrays here)
def copy object
	Marshal.load(Marshal.dump(object))
end

# Display the generated knight's path
def display_path path
	if path.length <= 1
		puts "You are already at your destination :-)"
    return
  end
	puts "You made it in #{path.length - 1} move#{path.length > 2 ? "s" : ""}! Here's your path:"
  path_string = ""
	path.each { |position| path_string += position.to_s + "-->" }
	path_string[-3..-1] = ""
	puts path_string
end


# knight_moves([0,0],[1,2]) # -> [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) # -> [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) # -> [[3,3],[1,2],[0,0]]
# knight_moves([3,3],[4,3])
