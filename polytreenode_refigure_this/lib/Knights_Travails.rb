
require_relative "00_tree_node"
class KnightPathFinder


  attr_accessor :start_pos, :considered_positions, :root_node
  grid = Array.new(8){Array.new(8)}

  POSSIBLE_MOVES = [
    [-2, 1],
    [-2, -1],
    [2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [1, 2],
    [1, -2]
  ]

  def self.valid_moves(pos)
    valid_moves = []

    given_x, given_y = pos

    POSSIBLE_MOVES.each do |(x, y)|
      new_pos = [given_x + x, given_y + y]
      
      if new_pos.all? {|x_y| x_y.between?(0,7)}
        valid_moves << new_pos
      end
    end
    valid_moves
    
  end


  def initialize(start_pos)
    @start_pos = start_pos
    @considered_positions = [start_pos]
    # @root_node = PolyTreeNode.new(start_pos)

    build_move_tree
    
  end
    


  def new_move_positions(pos)
   
   valid = KnightPathFinder.valid_moves(pos)
   
   unless @considered_positions.include?(pos) 
    @considered_positions << pos 
  end
      
    @considered_positions
  end

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)


    trace_path_back(end_node)
      .reverse
      .map(&:value)

  end

  trace_path_back(end_node)
    nodes = []

    current_node = end_node
    until current_node.nil? 
      nodes << current_node
      current_node = current_node.parent
    end
    nodes
  end

 


  def build_move_tree

    self.root_node = PolyTreeNode.new(start_pos)
    queue = [root_node]

    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |next_pos|
        next_queue_node = PolyTreeNode.new(next_pos)
        current_node.add_child(next_queue_node) 
        queue << next_queue_node
      end

    end 
      
    
  end




end

