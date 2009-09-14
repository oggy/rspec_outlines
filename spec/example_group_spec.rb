require 'spec_helper'

describe RSpecOutlines::ExampleGroup do
  before do
    @example_group = Class.new(Spec::Example::ExampleGroup)
  end

  describe "#outline" do
    it "should set the current outline to a new outline with the given name" do
      @example_group.outline("name of outline")
      @example_group.current_outline.should be_a(Outline)
      @example_group.current_outline.name.should == "name of outline"
    end
  end

  describe "#fields" do
    describe "when no outline has been defined" do
      it "should raise an Error" do
        lambda{@example_group.fields}.should raise_error(Error)
      end
    end

    describe "when an outline has been defined" do
      before do
        @outline = Outline.new(@example_group, "name of outline")
        @example_group.stubs(:current_outline).returns(@outline)
      end

      it "should set the fields of the last outline" do
        @example_group.fields(:a, :b)
        @outline.fields.should == [:a, :b]
      end

      it "should symbolize the given field names" do
        @example_group.fields('a', 'b')
        @outline.fields.should == [:a, :b]
      end
    end
  end

  describe "#values" do
    describe "when there is no current outline" do
      it "should raise an Error" do
        lambda{@example_group.values(1, 2)}.should raise_error(Error)
      end
    end

    describe "when the current outline has no fields defined" do
      before do
        @outline = Outline.new(@example_group, "name of outline")
        @example_group.stubs(:current_outline).returns(@outline)
      end

      it "should raise an Error" do
        lambda{@example_group.values(1, 2)}.should raise_error(Error)
      end
    end

    describe "when there is a current outline with fields defined" do
      before do
        @outline = Outline.new(@example_group, "name of outline"){}
        @outline.stubs(:fields).returns([:field_one, :field_two])
        @example_group.stubs(:current_outline).returns(@outline)
      end

      it "should define an example based on the last outline" do
        lambda{@example_group.values(1, 2)}.should change{@example_group.number_of_examples}.by(1)
      end

      it "should bind the given values to the example" do
        @example_group.values(1, 2)
        @example_group.example_proxies.last.outline_values.should == {:field_one => 1, :field_two => 2}
      end

      it "should raise an ArgumentError if the number of arguments is different to the number of fields" do
        lambda{@example_group.values(1)}.should raise_error(ArgumentError)
      end
    end
  end
end
