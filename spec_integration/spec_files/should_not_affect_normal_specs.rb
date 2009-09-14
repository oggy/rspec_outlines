# expect: .F

describe "A matcher implemented by method_missing" do
  it "should work properly in the passing case" do
    [].should be_empty
  end

  it "should work properly in the failing case" do
    [1].should be_empty
  end
end
