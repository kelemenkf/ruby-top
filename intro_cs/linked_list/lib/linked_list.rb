require_relative './node'

class LinkedList
    attr_accessor :head

    def initialize
        @head = nil
    end


    def append(value)
        return begin_list(value) if head.nil?
        
        tail.next_node = create_node(value)
    end
    
    def prepend(value)
        return begin_list(value) if head.nil?
        
        swap_head(value)
    end
    
    
    def tail(node = head)
        return node if last_node?(node)
        
        tail(node.next_node)
    end
    
    def size(node = @head, counter=1)
        return counter if last_node?(node)
        
        size(node.next_node, counter+1)
    end
    
    def pop(node=head)
        return node.next_node = nil if last_node?(node)
    
        pop(node.next_node)
    end

    def contains?(value, node=head)
        return true if node.value = value
        return false if last_node?(node)

        contains?(value, node.next_node)
    end

    def last_node?(node)
        return true if node.next_node == nil
        
        false
    end

    def at(index, counter=0, node=head)
        return node if counter == index

        at(index, counter+1, node.next_node)
    end

    def find(value, node=head, index=0)
        return index if node.value == value
        return nil if last_node?(node)

        find(value, node.next_node, index+1)
    end

    def to_s(node=head, string='')
        return string += "( #{node.value} ) => nil" if last_node?(node)

        string += "( #{node.value}) -> "
        to_s(node.next_node, string)
    end
       
    def create_node(value=nil, next_node=nil)
        Node.new(value, next_node)
    end

    def insert_at(index, value, counter=0)
        return "Unreachable index" if at(index).nil?
        return swap_head(value) if index==0

        return at(index-1).next_node = create_node(value, at(index)) if index == counter

        insert_at(index, value, counter+1)
    end
    
    def begin_list(value)
        self.head = create_node(value)
    end

    def swap_head(value)
        self.head = create_node(value, head)
    end

    def remove_at(index, counter=0)
        return "Unreachable index!" if at(index).nil?
        return self.head = at(1) if index.zero?
        return at(index-1).next_node = at(index+1) if index == counter

        remove_at(index, counter+1)
    end
end
