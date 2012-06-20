require 'tsort'

class Graph
  include TSort

  def initialize
    @nodes = Hash.new{|h,k| h[k] = []}
  end

  def add_node(name, *links)
    if @nodes.has_key?(name)
      @nodes[name] = @nodes[name].concat(links).uniq
    else
      @nodes[name] = links
    end
  end

  def tsort_each_node(&block)
    @nodes.each_key(&block)
  end

  def tsort_each_child(name, &block)
    @nodes[name].each(&block) if @nodes.has_key?(name)
  end

  def has_circular_references?
    strongly_connected_components.each { |ns| return true if ns.length != 1 }
    false
  end
end

