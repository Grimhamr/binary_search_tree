=begin
    
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

require "./lib/tree"
array= Array.new(15) { rand(1...100) }
tree = Tree.new(array)

puts tree.pretty_print

puts tree.balanced?

puts tree.level_order(0)
puts tree.level_order(1)
puts tree.level_order(2)
puts tree.level_order(3)
puts tree.preorder
puts tree.postorder
puts tree.inorder

tree.insert(13)
tree.insert(19)
tree.insert(87)
tree.insert(50)

puts "After the insertions, is the tree balanced?"
puts tree.balanced?
tree = tree.rebalance
puts "After rebalancing, is it balanced?"
puts tree.pretty_print
puts tree.balanced?

puts tree.level_order(0)
puts tree.level_order(1)
puts tree.level_order(2)
puts tree.level_order(3)
puts tree.preorder
puts tree.postorder
puts tree.inorder
