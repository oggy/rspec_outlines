Feature: Backward Compatibility

  Scenario: Specs not in an outline behave like normal
    Given this specification:
      """
      a = 1
      describe "A matcher implemented by method_missing" do
        b = 2
        it "should work properly in the passing case" do
          (a + b).should == 3
        end

        it "should work properly in the failing case" do
          (a + b).should == 'fail'
        end

        it "should work properly in the failing case" do
          c  # error
        end
      end
      """
    When I run rspec on it
    Then the output should contain ".FF"
