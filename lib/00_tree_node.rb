require 'byebug'


class PolyTreeNode

  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if @parent && node
      old_parent = @parent
      old_parent.children.delete(self)
      @parent = node
      @parent.children << self unless @parent.children.include?(self)
    elsif node
      @parent = node
      @parent.children << self unless @parent.children.include?(self)
    else
      @parent = nil
    end
    # if @parent.children.include?(self)
    #   old_parent.children.delete(self)
    # end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "ERROR" unless @children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs target_value
    queue = [self]
    until queue.empty?
      var = queue.shift
      return var if var.value == target_value
      queue.concat var.children
    end

    nil
  end

end


class KnightPathFinder
  attr_reader :move_tree, :visited_positions

  DELTAS = [[1,2],[2,1],[-1,-2],[-1,2],[1,-2],[2,-1],[-2,1],[-2,-1]].freeze


  def initialize(starting_pos)
    @move_tree = PolyTreeNode.new(starting_pos)
    @build_move_tree = build_move_tree
    @visited_positions = [starting_pos]
  end

  def find_path(end_pos)
  end

  def trace_path_back
  end

  def self.valid_moves(pos)
    result = []

    DELTAS.each do |delta|
      x = pos.first + delta.first
      y = pos.last + delta.last
      result << [x, y]
    end

    result.select{|pos| KnightPathFinder.on_board?(pos)}
  end


  def self.on_board?(pos)
    arr = []
    (0..7).each do |x|
      (0..7).each do |y|
        arr << [x, y]
      end
    end

    arr.include?(pos)
  end

  def new_move_positions(pos)
    debugger
    new_moves = KnightPathFinder.valid_moves(pos)
    new_moves.select{|pos| !@visited_positions.include?(pos)}

  end

  def build_move_tree
    method_name_sometime(@move_tree)
  end


  def method_name_sometime(node)
    node.children << new_move_positions(node.value).map{|el| PolyTreeNode.new(el)}

    node.children.each do |child|
      method_name_sometime(child)
    end

  end

end

# kpf = KnightPathFinder.new([0,0])
#
# kpf.build_move_tree
#
# kpf.move_tree
