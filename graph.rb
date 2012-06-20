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
    strongly_connected_components.each do |ns|
      if ns.length != 1
        return true
      end
    end
    false
  end
end

class ProcessList
  def initialize
    @graph = Graph.new
  end

  def add_process(process_id, resource_id, hold_wait)
    raise ArgumentError, 'hold wait must be either :hold or :wait' if hold_wait != :hold and hold_wait != :wait

    if hold_wait == :hold
      @graph.add_node(process_id, resource_id)
    else
      @graph.add_node(resource_id, process_id)
    end
  end

  def is_deadlocked?
    @graph.has_circular_references?
  end
end