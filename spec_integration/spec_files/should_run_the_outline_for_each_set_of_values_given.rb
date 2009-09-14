# expect: ..F

require 'rspec_outlines'

describe "Adding two numbers" do
  outline "should return the sum" do
    (a + b).should == c
  end
  fields :a, :b, :c
  values  1,  1,  2
  values -1, -2, -3
  values  1,  2, 10
end
