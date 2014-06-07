# Class defining the node to be used in a Binary Search Tree
class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value, parent = nil, left_child = nil, right_child = nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

	# Put all instance variables of a node in an easily read string
	def to_s
		str = ""
		str += "< Node: @value=#{@value}\n"
		str += @parent.nil? ? "\t@parent: Nil\n" : "\t@parent: #{@parent.value}\n"
		str += @left_child.nil? ? "\t@left_child: Nil\n" : "\t@left_child: #{@left_child.value}\n"
		str += @right_child.nil? ? "\t@right_child: Nil>" : "\t@right_child: #{@right_child.value}>"
		str
	end

	def <=>(other)
		@value <=> other.value
	end

end
