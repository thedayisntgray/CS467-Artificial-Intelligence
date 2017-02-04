=begin

Exhaustive Search -

Add an exhaustive search to your program that will insure an optimal answer for any input. Read in a file that contains information about the items. Create a binary tree that contains all possible sacks (items combinations) as leaf nodes. Under the root node will be a left child and a right child. The left child should represent that the first item was not selected for the sack. The right child should represent that the first item was selected for the sack. Each of these two nodes will then have their own left child (item two not taken) and right child (item two is taken). A diagram of this was shown in class. You will need one level in the tree for each item available. Once the tree is completed, calculate the sum of the values and costs in each sack (the leaf nodes). Output the combination of items (the items will have names) that has the higest sum value, but also has a sum cost that is equal or less than the total cost limit. Output the total value, total cost, and an alphabetical list of the items.

You will notice that as the number of possible items increase, you will have to do a depth-first search instead of a breadth-first search, or you will likely run out of memory.

=end



#Modified BST example from 
#http://www.mikeperham.com/2014/11/26/building-a-binary-tree-with-enumerable/
#http://rubyalgorithms.com/binary_search_tree.html

class BinarySearchTree
	class Item
		attr_accessor :name, :value, :cost, :taken
		#alias_method :isTaken?, :taken

		def initialize

		end

		def initialize(name,value,cost)
			@name = name
			@value = value
			@cost = cost
		end

	end

	class Node
		include Enumerable
		attr_accessor :name, :data, :left, :right
		#i want to implement an item class with a comparable that has a name and data.
		
		def initialize(data)
			@data = data
		end

		def each(&block)
			left.each(&block) if left
			block.call(self)
			right.each(&block) if right
		end

		def <=>(other_node)
			data <=> other_node.data
		end
	end


	def initialize
		@root = Node.new(nil)
		@depth = 0
	end

	def depth_first(max_cost,node,arr,generate_solution, best_solution, depth)
	p "depth  #{depth}"
		#go left
		if depth < arr.length
			p "Item added to tree = #{arr[depth]}"

			node.left = Node.new(arr[depth])
			depth_first(max_cost,node.left,arr,generate_solution,best_solution, depth + 1)
		else
			#sum up the genereate node and compare to best max, if it is greater this new generated set is the best set and has the new max as long as it is less than the cost
			p "generate solution #{generate_solution}"
			p "best solution:  #{best_solution}"
			cost = sum_cost(generate_solution)
			value = sum_val(generate_solution)
			puts "Left - MAX COST #{max_cost} \nCOST: #{cost} \nVALUE: #{value} \nBEST VALUE: #{sum_val(best_solution)}"
			if cost < max_cost  and value > sum_val(best_solution)
				p "generate_solution.dup : #{generate_solution.dup} "
				best_solution = generate_solution.dup
				p "best_solution : #{generate_solution.dup} "
				generate_solution = []
				p "generate_solution = [] : #{ generate_solution} "
				p "best_solution becomes :  #{ best_solution} "
				return best_solution
			end
			puts "\ndepth in else   #{depth}\n"
		end
			
		#if node is nil we are at root node

		#go right
		if depth < arr.length
			node.right = Node.new(arr[depth])
			generate_solution << node.right.data
			depth_first(max_cost,node.right,arr,generate_solution,best_solution, depth + 1)
			poppy = generate_solution.pop
			p "popped #{poppy}"
		else
			#sum up the genereate node and compare to best max, if it is greater this new generated set is the best set and has the new max as long as it is less than the cost
			cost = sum_cost(generate_solution)
			value = sum_val(generate_solution)
			if cost < max_cost  and value > sum_val(best_solution)
				best_solution = generate_solution.dup
				generate_solution = []
				return best_solution
			end
			puts "\ndepth in 2nd else   #{depth}\n"
		end
	end
	
	def sum_cost(arr)
		sum = 0
		return sum if arr.empty?
		arr.each do |item|
			sum += 0 if item.nil?
			sum += item[1].to_i
		end
		return sum.to_i
	end

	def sum_val(arr)
		sum = 0
		return sum if arr.empty?
		arr.each do |item|
			sum += 0 if item.nil?
			sum += item[2].to_i
		end
		return sum.to_i
	end

	#Let arr be an array of items for ease of use
	def depth_first_search(arr, max_cost)
		#array with best solution
		best_solution = []
		depth = 0

		generate_solution = []
		
		item_node = Node.new(nil)
		#return path
		return depth_first(max_cost, item_node,arr,generate_solution,best_solution,depth)

	end

end

def main
	#format input
	input = []
	File.foreach(ARGV[0], 'r') do |f|
		input = f.gsub(/\n/," ")
		input = input.gsub(/\r/," ")
		input = input.gsub(','," ")
		input = input.split
	end
	
	maxWeight = input[0].to_i

	#toss the max weight from input
	input = input.drop(1).each_slice(3).to_a

	#	p input
	#	max_cost sum_cost(input)
	
	#p "MAX COST IS : #{max_cost}"

	tree = BinarySearchTree.new

	p "THE BEST SOLUTION IS " +  tree.depth_first_search(input, maxWeight)

end

main()
=begin
root = Node.new(3)
root.left = Node.new(2)
root.right = Node.new(1)

# just a few of the various operations Enumerable provides
puts "SUM"
puts root.inject(0) { |memo, val| memo += val.data }
puts "MAX"
puts root.max.data
puts "SORT"
puts root.sort.map(&:data)

=end
