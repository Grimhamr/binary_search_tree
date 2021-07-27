=begin
Build a Node class. It should have an attribute for the data it stores as well as its left and right children. 
As a bonus, try including the Comparable module and compare nodes using their data attribute.

Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute which uses the return 
value of #build_tree which you’ll write next.



Write an #insert and #delete method which accepts a value to insert/delete (you’ll have to deal with several cases for delete 
such as when a node has children or not). If you need additional resources, check out these two articles on inserting and deleting, 
or this video with several visual examples.

Write a #find method which accepts a value and returns the node with the given value.

Write a #level_order method that returns an array of values. This method should traverse the tree in breadth-first level order. 
This method can be implemented using either iteration or recursion (try implementing both!). Tip: You will want to use an array acting 
as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list (as you saw in the video).

Write #inorder, #preorder, and #postorder methods that returns an array of values. Each method should traverse the tree 
in their respective depth-first order.

Write a #height method which accepts a node and returns its height. Height is defined as the number of edges in 
longest path from a given node to a leaf node.

Write a #depth method which accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

Write a #balanced? method which checks if the tree is balanced. A balanced tree is one where the difference 
between heights of left subtree and right subtree of every node is not more than 1.

Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to create a level-order array 
of the tree before passing the array back into the #build_tree method.

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
    include Comparable
    attr_accessor :left, :right, :data

    def initialize(data)
        
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    #@build_tree = build_tree [1, 7, 4, 23, 8, =>9, 3, 5, 67, 6345, 324]
    def initialize(array)
        array = array.uniq
        build_tree(array)
    end 

    def create_children(node,array)
        
        pretty_print
        p "checking array"
        if array.nil?  || array.empty?
            p array
             p "nil found in array"
             
            return
        elsif array.length==1
            node.left = Node.new(array[0])
            puts "end of branch"
            return
        elsif array.length == 2
            if array[0] > array[1]
                node.left = Node.new(array[1])
                node.right = Node.new(array[0])
            else 
                node.left = Node.new(array[0])
                node.right = Node.new(array[1])
            end
             
        
        end
        puts "#{array} not nil. proceeding"

        p "generating children nodes for #{node.data}"
           @position_left = array.length/2 - 1
            @position_right = array.length/2 
       
        if array[@position_left] > array[@position_right]
            node.left = Node.new(array[@position_right])
            node.right = Node.new(array[@position_left])
        else 
            node.left = Node.new(array[@position_left])
            node.right = Node.new(array[@position_right])
        end
        

        array.delete_at(@position_right)

        array.delete_at(@position_left)
        

        left_array = array.slice(0,@position_left)

        

     
        

        p "left array deployed from #{array}. #{left_array}"
        create_children(node.left, left_array )
        
       
        if array[@position_right].nil?
            return
        end
        right_array = array.slice(array[@position_right],array[-1])
        create_children(node.right, right_array)

    end

    def build_tree(array)
        if array.nil? || array.length==0
            puts "array empty. returning"
            return
        end
        print "building tree from array:"
        array = array.uniq
        puts array.length
        p array

          
            @root = Node.new(array[array.length/2])
            
                p "root is #{array[array.length/2]}"
            
                array.delete_at(array.length/2)

                
                    @position_left = array.length/2 -1
                    @position_right = array.length/2 
            
                    left_array = array.slice(0,array[@position_left])
                    right_array = array.slice(array[@position_left], array[-1])
                    
                    p "left #{left_array} vs right_array #{right_array} after root deletion"
                create_children(@root,array)
                

       @root             
            
         
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end

end
tree = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
#tree = Tree.new([9,1,4,7,8,6,5,3,2,4,6,7,10,13,14,12,11])
p "final:"
tree.pretty_print































