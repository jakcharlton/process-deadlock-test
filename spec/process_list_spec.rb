describe ProcessList do
  it "wont allow anything but :wait or :hold" do
    lambda { subject.add_process(1, 1, :doesnt_exist) }.should raise_error
  end

  it "adds nodes with hold" do
    subject.add_process(1, 2, :hold)
    subject.is_deadlocked?.should == false
  end

  it "adds nodes with wait" do
    subject.add_process(1, 2, :wait)
    subject.is_deadlocked?.should == false
  end

  it "has wait and hold inversed not causing deadlock" do
    subject.add_process(1, 2, :wait)
    subject.add_process(2, 1, :hold)
    subject.is_deadlocked?.should == false
  end

  it "has wait and hold inversed causing deadlock" do
    subject.add_process(1, 2, :wait)
    subject.add_process(1, 2, :hold)
    subject.is_deadlocked?.should == true
  end

  it "shows deadlock on test data" do
    subject.add_process(1, 1, :hold)
    subject.add_process(1, 2, :wait)
    subject.add_process(2, 1, :wait)
    subject.add_process(2, 2, :hold)
    subject.is_deadlocked?.should == true
 end
end