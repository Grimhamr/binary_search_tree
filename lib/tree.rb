=begin

Tie it all together
Write a simple driver script that does the following:

Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
Confirm that the tree is balanced by calling #balanced?
Print out all elements in level, pre, post, and in order
Unbalance the tree by adding several numbers > 100
Confirm that the tree is unbalanced by calling #balanced?
Balance the tree by calling #rebalance
Confirm that the tree is balanced by calling #balanced?
Print out all elements in level, pre, post, and in order

=end
class Node
    attr_accessor :data, :left, :right

    def initialize(data)
    @data = data
    @left = nil
    @right = nil
    end

end

class Tree
    attr_accessor :root, :root_node
    def initialize(array)
        array = array.sort.uniq
        @root = build_tree(array)
    end

    def build_tree(array)
        
        return nil if array.empty?

        middle = (array.length - 1) / 2
        root_node = Node.new(array[middle])
        
        root_node.left = build_tree(array[0...middle])
        root_node.right = build_tree(array[(middle + 1)..-1])
    
        
        

        #returns level0 root node
  
        root_node
    end

    def find(data, node = root)
        return if node.nil?
        if node.data == data
            #puts "#{data} instance located. insertion invalid, deletion valid"
            @insertion_valid = false
            @found_instance = node
           
        else 
            find(data, node.left)
            find(data, node.right)
        end
        unless @found_instance == nil
            return @found_instance if @found_instance.data == data
        end
    end

    def find_insert_node(data, node = root)
        return if node.nil?
        if node.data < data
            if node.right.nil? && !(node.left.nil?)
                node.right = Node.new(data)
                puts "#{data} inserted in node:"
                p node
            elsif node.right.nil? && node.left.nil?
                node.right = Node.new(data)
                puts "#{data} inserted in node:"
                p node
            elsif !(node.right.nil?) && node.left.nil?
                if data < node.right.data && data < node.data
                    node.left = Node.new(data) 
                else    
                    find_insert_node(data, node.right)
                end
            else
                find_insert_node(data, node.right)
            end
        else
            if node.left == nil
                node.left = Node.new(data) 
            else
                find_insert_node(data,node.left)
            end
        end
    end

    def insert(data)

        @insertion_valid = true
        find(data)

        if @insertion_valid == true
            puts "insertion valid. inserting #{data}"
            find_insert_node(data)
        end
    end

    def delete(data, node = root)
        
        find(data)
        unless node.nil?
            unless node.left.nil?
                puts "checking left at #{node.data}"
                    if !(node.left.data.nil?)  
                            puts "left is #{node.left.data}" 
                            #puts "comparing #{node.left.data} with #{@found_instance.data}"
                            if node.left.data == @found_instance.data 
                               puts "LOCATED!!!!@!@!@!@!@!@!@!deleting: #{node.left.data}"
                               node.left=nil
                            end
                    end
            end
            unless node.right.nil?
                if !(node.right.data.nil?)
                    puts "checking right at #{node.data}"
                    unless node.right.data.nil?
                        puts "right is #{node.right.data}"
                        if node.right.data == @found_instance.data
                            puts "deleting: #{node.right.data}"
                            node.right = nil
                        end
                    end
                end
            end
    
            delete(data, node.left)
            delete(data, node.right)
        end
    end

    #Write a #level_order method that returns an array of values. This method should traverse the tree in breadth-first level order. 
    #This method can be implemented using either iteration or recursion (try implementing both!). Tip: You will want to use an array acting 
    #as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list (as you saw in the video).
    def level_order(order)
        level = level_order_find(order)
        #reset hash
        @levels_hash = nil
        return level
    end
    def level_order_find(order, node = root,  i = 0)
        #create hash with arrays of the  levels in it
        @levels_hash ||= Hash.new
        #create array of level if it doesn't exist
        @levels_hash[i] ||= []

        #add root.data to array
        unless node.nil?
            unless node.data.nil?
                @levels_hash[i].push(node.data)
                #increase counter
                i = i + 1
                level_order_find(order,node.left,i)
                level_order_find(order,node.right,i)
            end
        end

        return @levels_hash[order]
    end

            #Write #inorder, #preorder, and #postorder methods that returns an array of values. Each method should traverse the tree 
        #in their respective depth-first order.

    def inorder(node = root)
        #left, visit, right
        @inorder_array ||= []

        unless node.left.nil?
            inorder(node.left)
        end

        @inorder_array.push(node.data)
        unless node.right.nil?
            inorder(node.right)
        end

        @inorder_array
    end
    
    def preorder(node = root)
        #visit, left, right
        @preorder_array ||= []
        @preorder_array.push(node.data)
        unless node.left.nil?
            preorder(node.left)
        end
        
        unless node.right.nil?
            preorder(node.right)
        end

        @preorder_array
    end
    
    def postorder(node = root)
        #left, right, visit
        @postorder_array ||= []
     
        unless node.left.nil?
            postorder(node.left)
        end
         unless node.right.nil?
            postorder(node.right)
        end
        @postorder_array.push(node.data)

        @postorder_array
    end

    #Write a #height method which accepts a node and returns its height. Height is defined as the number of edges in 
    #longest path from a given node to a leaf node.

    def height(node = root)
        unless node.nil? || node == root
          node = (node.instance_of?(Node) ? find(node.data) : find(node))
        end
    
        return -1 if node.nil?
    
        [height(node.left), height(node.right)].max + 1
    end
    
    def depth(node, i=0)
    
        unless level_order(i).nil?
            if level_order(i).include?(node)
                p "depth of #{node} is #{i}"
                return i
            else
                depth(node,i+1)
            end
        end
  
    end

    #Write a #balanced? method which checks if the tree is balanced. A balanced tree is one where the difference 
    #between heights of left subtree and right subtree of every node is not more than 1.
    def balanced?(node=root)
       return true if node.nil?
        left_node_height = height(node.left)
        right_node_height = height(node.right)

        return true if (left_node_height - right_node_height).abs <=1 && balanced?(node.left) && balanced?(node.right)

        false
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def rebalance(i=0,array = [])
        #Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to create a level-order array 
        #of the tree before passing the array back into the #build_tree method.
        
        #get level order of i; i+=1 until level order.compact.empty?
        array.push(level_order(i))
        unless level_order(i).compact.empty?
            i += 1
            rebalance(i, array)
        else
            balanced_tree = Tree.new(array.flatten)
        end
    end
end

array= Array.new(25) { rand(1...100) }
tree = Tree.new(array)

tree.pretty_print
tree.insert(13)

tree.insert(88)

tree.pretty_print
puts "deleting"
tree.delete(88)

tree.pretty_print

tree.insert(88)

tree.pretty_print


p tree.find(13)

p tree.find(24)
puts "level order"
p tree.level_order(3)

puts "inorder"
p tree.inorder

puts "preorder"
p tree.preorder

puts "postorder"
p tree.postorder


puts tree.height(13)



puts tree.height(65)

puts tree.depth(13)


puts tree.depth(61)


puts tree.balanced?
puts "Rebalanced tree:"
puts tree.rebalance.pretty_print



























