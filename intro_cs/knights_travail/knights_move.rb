class Node
    attr_accessor :start, :childs
    def initialize(pos=[0,0])
        @start = pos
        @childs = []
    end

    #at every point all the options of the knight has to be considered
    #we can add 1 to the column 2 to the row
    #or 2 to the column and 1 to the row.
    #starting node has max 8 childs
    #every child can have further steps
    #the graph can be infinite so how deep should it be?
    #increase only if it is not found.
end

class Board
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

    def build_tree(step=1, counter=0,start=[0,0])
        root = Node.new(start)
        self.knight(start[0], start[1])

        return root if step == counter

        rank_steps = [1,2,2,1,-1,-2,-2,-1]
        file_steps = [-2,-1,1,2,2,1,-1,2]
        for i in (0..7)
            r = rank_steps[i] + root.start[0]
            c = file_steps[i] + root.start[1]
            pos = []
            pos << r
            pos << c
            if (0..7).include?(r) && (0..7).include?(c)
                root.childs << build_tree(step, counter+1, pos)
            end
        end
    end
end

board = Board.new()
board.to_s
board.build_tree(10)
board.to_s