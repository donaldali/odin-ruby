require './node'

# Binary Search Tree class
class BST
	attr_accessor :root

	# Sets the root of the BST if data for the root is provided
	def initialize(root_data = nil)
		@root = Node.new(root_data) unless root_data.nil?
	end

	# Class method to build a BST from an array of values
	def BST.build_tree data_array
		bst = BST.new
		data_array.each { |data| bst.add(data) }
		bst
	end

	# Create a node for provided data and add node to BST
	def add node_data
		if @root.nil?
			@root = Node.new(node_data)
		else
			add_to_bst(Node.new(node_data), @root)
		end
	end

	# Helper method to add a node to a BST
	def add_to_bst(node, ancestor)
		return node if ancestor.nil?

		node.parent = ancestor
		if node.value < ancestor.value
			ancestor.left_child = add_to_bst(node, ancestor.left_child)
		else
			ancestor.right_child = add_to_bst(node, ancestor.right_child)
		end
		ancestor				
	end

	# Provide an array of the values in the BST when the BST is traversed inorder
	def inorder
		tree_data = []
		tree_data = inorder_traverse(@root, tree_data)
	end

	# Helper method to traverse the BST in order
	def inorder_traverse(node, data)
		return data if node.nil?
		inorder_traverse(node.left_child, data)
		data << node.value
		inorder_traverse(node.right_child, data)
	end

	# Display the nodes of the BST as they are visited in order
	def inorder_display
		puts "ROOT: #{@root.value}\n"
		inorder_display_helper @root
	end

	# Helper method to display nodes (with Node's to_s) of BST in order 
	def inorder_display_helper node
		return nil if node.nil?
		inorder_display_helper(node.left_child)
		puts node.to_s
		inorder_display_helper(node.right_child)
	end

	# Search the BST for a target using breadth first search
	def breadth_first_search target
		open_queue = [@root]
		until open_queue.empty?
			current = open_queue.shift
			return current if current.value == target
			open_queue.push current.left_child unless current.left_child.nil?
			open_queue.push current.right_child unless current.right_child.nil?

		end
		nil
	end

	# Search the BST for a target using depth first search
	def depth_first_search target
		open_stack = [@root]
		until open_stack.empty?
			current = open_stack.pop
			return current if current.value == target
			open_stack.push current.right_child unless current.right_child.nil?
			open_stack.push current.left_child unless current.left_child.nil?

		end
		nil
	end

	# Search the BST for a target using a recursive depth first search
	def dfs_rec target
		dfs_rec_helper(target, @root)
	end

	# Helper method for a recursive depth first search of BST
	def dfs_rec_helper(target, node)
		return nil if node.nil?
		return node if node.value == target
		
		left_search = dfs_rec_helper(target, node.left_child)
		return left_search unless left_search.nil?
		right_search = dfs_rec_helper(target, node.right_child)
		return right_search unless right_search.nil?
		nil
	end

end

# Perform some tests of the BST
def run_build_tree
	bst = BST.build_tree([7, 1, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
	puts "****** Begin BST Nodes ******"
	bst.inorder_display
	puts "******* End BST Nodes *******"
  puts "Inorder list of node values: #{bst.inorder}"

  puts "Check BFS"
  puts bst.breadth_first_search 5
  puts bst.breadth_first_search 8
  p bst.breadth_first_search 15 # => nil

  puts "Check DFS"
  puts bst.depth_first_search 5
  puts bst.depth_first_search 8
  p bst.depth_first_search 15 # => nil

  puts "Check recursive DFS"
  puts bst.dfs_rec 5
  puts bst.dfs_rec 8
  p bst.dfs_rec 15 # => nil
end

if ARGV[0] && ARGV[0].chomp.downcase =~ /test/
  run_build_tree
end
