require 'spec_helper'

describe ExampleMethods do
  describe "#execute" do
    before do
      @example_group = Class.new(Spec::Example::ExampleGroup)
      @run_options = Spec::Runner::Options.new(StringIO.new, StringIO.new)
      @run_options.reporter.example_group_started(@example_group)
    end

    describe "when outline values are present" do
      before do
        @proxy = Spec::Example::ExampleProxy.new("description")
        @proxy.outline_values = {:x => 5}
      end

      it "should give the implementation access to the outline values" do
        value = nil
        example_group_instance = @example_group.new(@proxy) do
          value = x
        end
        example_group_instance.execute(@run_options, {}).should be_true
        value.should == 5
      end
    end

    describe "when outline values are not present" do
      before do
        @proxy = Spec::Example::ExampleProxy.new("description")
      end

      it "should give the implementation access to the outline values" do
        error = nil
        example_group_instance = @example_group.new(@proxy) do
          begin
            x
          rescue NameError => error
          end
        end
        example_group_instance.execute(@run_options, {}).should be_true
        error.should_not be_nil
        error.message.should include("`x'")
      end
    end
  end
end
