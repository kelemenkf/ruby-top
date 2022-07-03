class Node
    attr_accessor :pos, :childs
    def initialize(pos=[0,0])
        @pos = pos
        @childs = []
    end
end

class Tree
    attr_accessor :root, :steps
    def initialize(steps, root)
        @steps = steps
        @root = Node.new(root)
    end

    def build_tree(step=self.steps, root=self.root, counter=0)
        return nil if step < counter
        rank_steps = [1,2,2,1,-1,-2,-2,-1]
        file_steps = [-2,-1,1,2,2,1,-1,2]
        for i in (0..7)
            r = rank_steps[i] + root.pos[0]
            c = file_steps[i] + root.pos[1]
            pos = []
            pos << r
            pos << c
            pos = Node.new(pos)
            if (0..7).include?(r) && (0..7).include?(c)
                root.childs << build_tree(step, pos, counter+1)
            end
        end
        root
    end


    def find(value=[0,0], root=self.root, queue = [])
        return root if root.pos == value
        #separate levels by an indicator to know level
        for i in root.childs
            if !(i.nil?)
                queue << i
            end
        end
        return "not in tree" if queue.empty?
        find(value, queue.shift, queue) 
    end

    def path(root=self.root, value=[0,0], path=[],  target=find(value))
        return target.pos if root == target

        for i in root.childs
            if i == target
                path << root.pos
                path << path(root.childs[root.childs.index(target)], value, path)
            end
        end
        return path
    end


    def pretty_tree
        puts "#{root.pos} \n #{root.childs}"
    end
end

class Board < Tree
    attr_accessor :board
    def initialize
        @board = Array.new(8) {Array.new(8)}
    end

    def to_s
        8.times do |i|
            puts "#{board[i]}"
        end
    end

    def knight(r,f)
        self.board[r][f] = "K"
        return 
    end
end


tree = Tree.new(2, [0,0])
tree.build_tree()
p tree.path(tree.root, [1,2])