=begin
Build a Node class. It should have an attribute for the data it stores as well as its left and right children. 
As a bonus, try including the Comparable module and compare nodes using their data attribute.

Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute which uses the return 
value of #build_tree which you’ll write next.

Write a #build_tree method which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) 
and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). 
The #build_tree method should return the level-0 root node.

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
    attr_accessor :data, :left, :right

    def initialize(data)
    @data = data
    @left = nil
    @right = nil
    end

end

class Tree

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
        p root_node
        root_node
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end

end
#tree = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])

array= Array.new(17) { rand(1...100) }
tree = Tree.new(array)

tree.pretty_print































