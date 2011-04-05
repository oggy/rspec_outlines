# RSpec Outlines

Cuke-style scenario outlines for RSpec.

## Example

    describe User do
      outline "should validate correctly" do
        @user = Factory(:user, name => value)
        @user.errors[name].should == message
      end

      fields :name    , :value, :message
      values :name    , ""    , "name is required"
      values :password, ""    , "password is required"
      values :password, "hi"  , "password too weak"
    end

This defines 3 examples. Each one consists of the block given to `outline`, with
`name` and `value` set to the values given in the table below it.

## Usage

As in the example above, use `outline` to define a spec outline, `fields` to
declare the variables, and `values` to create an example with the given values
bound to those variables.

There are also some tricks you can play with `outline`.

## Substitutions in example descriptions

Use `:foo` in the description of an outline to substitute the value `foo` from
the table:

    outline ":a + :b + :c should be :result" do
      (a + b + c).should == result
    end

This will produce names like:

    2 + 3 + 5 should be 10

This lets you keep your spec names descriptive and unique. You may also delimit
the field name in braces if you want to append something to a value. Example:

    outline ":{controller_name}Controller works correctly"

Might produce names like:

    UsersController works correctly

You can also interpolate a 1-based index using `:#`. Example:

    outline "should work (:#)" do
      ...
    end

Will produce names:

    should work (1)
    should work (2)
    should work (3)
    ...

Useful when you just want to keep your spec names distinct, but don't care
enough to name them perfectly.

If your name does not contain any interpolations, RSpec Outlines will
automatically append `" (:#)"` to your outline name.

## Multiple examples per outline

If you omit the string argument to `outline`, the block will be evaluated at the
example group level.

    describe "Adding or multiplying two numbers" do
      outline do
        it "should return the sum"
          (a + b).should == sum
        end

        it "should return the product"
          (a * b).should == product
        end
      end

      fields :a, :b, :sum, :product
      values  1,  1,    2,        1
      values -1, -2,   -3,        2
      values -1,  1,    0,       -1
    end

This lets you define multiple specs inside the block, or use more elaborate
logic to compute the spec descriptions.

## Contributing

 * [Bug reports](https://github.com/oggy/rspec_outlines/issues)
 * [Source](https://github.com/oggy/rspec_outlines)
 * Patches: Fork on Github, send pull request.
   * Include tests where practical.
   * Leave the version alone, or bump it in a separate commit.

## Copyright

Copyright (c) George Ogata. See LICENSE for details.
