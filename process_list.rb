class ProcessList
  def initialize
    @graph = Graph.new
  end

  def add_process(process_id, resource_id, hold_wait)
    case hold_wait
      when :hold
        @graph.add_node(process_id, resource_id)
      when :wait
        @graph.add_node(resource_id, process_id)
      else
        raise ArgumentError, 'hold wait must be either :hold or :wait'
    end
  end

  def is_deadlocked?
    @graph.has_circular_references?
  end
end
