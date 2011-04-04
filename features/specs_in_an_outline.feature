Feature: Specs In An Outline

  Scenario: A single spec in an outline
    Given this specification:
      """
      describe "Adding two numbers" do
        outline do
          it "should return the sum" do
            (a + b).should == c
          end
        end
        fields :a, :b,    :c
        values  1,  1,     2
        values -1, -2,    -3
        values  1,  2, :fail
      end
      """
    When I run rspec on it
    Then the output should contain "..F"

  Scenario: Multiple specs in an outline
    Given this specification:
      """
      describe "Adding two numbers" do
        outline do
          it "should return the sum" do
            (a + b).should == c
          end
        end
        fields :a, :b,    :c
        values  1,  1,     2
        values -1, -2,    -3
        values  1,  2, :fail
      end
      """
    When I run rspec on it
    Then the output should contain "..F"

  Scenario: Using the single spec shortcut
    Given this specification:
      """
      describe "Adding two numbers" do
        outline "should return the sum" do
          (a + b).should == c
        end
        fields :a, :b,    :c
        values  1,  1,     2
        values -1, -2,    -3
        values  1,  2, :fail
      end
      """
    When I run rspec on it
    Then the output should contain "..F"
