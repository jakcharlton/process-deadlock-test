class ProcessList
  def initialize
    @graph = Graph.new
  end

  def add_process(process_id, resource_id, hold_wait)
    raise ArgumentError, 'hold wait must be either :hold or :wait' unless [:hold, :wait].include? hold_wait

    hold_wait == :hold ? @graph.add_node(process_id, resource_id) : @graph.add_node(resource_id, process_id)
  end

  def is_deadlocked?
    @graph.has_circular_references?
  end
end
