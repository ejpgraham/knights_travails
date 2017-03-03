require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if @parent
      old_parent = self.parent
      old_parent.children.delete(self)
    end

    if node.nil?
      @parent = nil
    else
      @parent = node
      node.children << self unless node.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" if child_node.parent.nil?
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value

      current_node.children.each do |child|
        queue.push(child)
      end
    end

    nil
  end

  def inspect
    @value
  end
end
