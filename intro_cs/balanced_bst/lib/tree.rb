require_relative './node'

class Tree

    attr_accessor :data, :root

    def initialize(array)
        @data = array.sort.uniq
        @root = build_tree(data)
    end

    def build_tree(arr)
        return nil if arr.empty? 

        mid = (arr.size-1)/2
        root = Node.new(arr[mid])

        root.left = build_tree(arr[0...mid])
        root.right = build_tree(arr[mid+1..arr.length-1])

        return root
    end

    def insert(value, node=root)
        return nil if value == node.value

        if value < node.value
            node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else
            node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end
    end

    def minValueNode(node=root)
        current = node

        while !current.left.nil?
            current = current.left
        end

        return current
    end

    def delete(node=root, value)
        return node if node.nil? 

        if value < node.value
            #why is there assingment here? If the next call on the stack returned something,
            #the tree has to be adjusted so what was one level below now becomes above.
            node.left = delete(node.left, value)
        elsif value > node.value
            node.right = delete(node.right, value)
        else
            return node.right if node.left.nil?
            return node.left if node.right.nil?

            temp = minValueNode(node.right)
            node.value = temp.value
            node.right = delete(node.right, node.value)
        end
        node
    end

    def find(value, node=root)
        return node if node.value == value || node.nil?

        if value < node.value
            find(value, node.left)
        elsif value > node.value
            find(value, node.right)
        end
    end
    
    def level_order(node=root, queue = [])
        print "#{node.value} "
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
        return if queue.empty?

        level_order(queue.shift, queue)
    end

    def inorder(node=root)
        if node
            inorder(node.left)
            print "#{node.value} \n"
            inorder(node.right)
        end
    end

    def preorder(node=root)
        if node 
            print "#{node.value} \n"
            preorder(node.left)
            preorder(node.right)
        end
    end

    def postorder(node=root)
        if node 
            postorder(node.left)
            postorder(node.right)
            print "#{node.value} \n"
        end
    end

    def height(node=root)
        return 0 if node.nil? 

        lheight = height(node.left)
				p lheight
        rheight = height(node.right)
				p rheight

        if lheight > rheight
            return lheight + 1
        else
            return rheight + 1
        end
    end

		def depth(node=root, parent=root, edges=0)
			return 0 if node == parent
			return -1 if parent.nil?

			if node < parent.value
				edges += 1
				depth(node, parent.left, edges)
			elsif node > parent.value
				edges += 1
				depth(node, parent.right, edges)
			else 
				edges
			end
		end

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end
end

arr = [2,1,53,5,3,5,2,97,59,69,5]
bst = Tree.new(arr)
bst.insert(50)
bst.insert(4)
bst.insert(26)
bst.pretty_print
bst.delete(4)
bst.delete(26)
bst.pretty_print
p bst.height