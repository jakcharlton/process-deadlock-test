require './graph.rb'

describe Graph do
  it "has circular references for test data" do
    subject.add_node(1, 1)
    subject.add_node(2, 1)
    subject.add_node(1, 2)
    subject.add_node(2, 2)
    subject.has_circular_references?.should == true
  end

  it "has circular references for simple graph" do
    subject.add_node(1, 2)
    subject.add_node(2, 1)
    subject.has_circular_references?.should == true
  end

  it "doesnt have circular references for simple graph" do
    subject.add_node(1, 2)
    subject.add_node(2, 3)
    subject.has_circular_references?.should == false
  end
end

