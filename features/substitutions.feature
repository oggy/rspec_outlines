Feature: Substitutions

  Scenario: An outline with a :variable in the description
    Given this specification:
      """
      describe "Test" do
        outline "- :a -" do
        end
        fields :a
        values 1
      end
      """
    When I run rspec with "-fs" on it
    Then the output should contain "- 1 -"

  Scenario: An outline with a :{variable} in the description
    Given this specification:
      """
      describe "Test" do
        outline "- :{a}a -" do
        end
        fields :a
        values 1
      end
      """
    When I run rspec with "-fs" on it
    Then the output should contain "- 1a -"

  Scenario: An outline with a :# in the description
    Given this specification:
      """
      describe "Test" do
        outline "- :# -" do
        end
        fields :a
        values 1
        values 2
      end
      """
    When I run rspec with "-fs" on it
    Then the output should contain "- 1 -"
    And the output should contain "- 2 -"

  Scenario: An outline with no interpolations in the description
    Given this specification:
      """
      describe "Test" do
        outline "should work" do
        end
        fields :a
        values 1
        values 2
      end
      """
    When I run rspec with "-fs" on it
    Then the output should contain "should work (1)"
    And the output should contain "should work (2)"
