# RSpec Outlines

Cuke-style scenario outlines for RSpec.

## Example

    describe "Adding three numbers" do
      outline "should return the sum" do
        (a + b + c).should == result
      end

      fields :a, :b, :c, :result
      values  1,  1,  2,       4
      values -1, -2, -3,      -6
      values -1,  1,  0,       0
    end

This defines 3 examples. Each one consists of the block given to `outline`, with
`a`, `b`, and `c` set to the values given in the table below it. Easy, huh?

Aside from being a more readable way to write repetitive specs, tables are a
great way to see that you've covered all the combination of arguments you need
to test.

For example, suppose in the above example you want to ensure you've checked
using every combination of positive and negative arguments:

      fields :a, :b, :c, :result
      values  2,  3,  5,      10
      values  2,  3, -5,       0
      values  2, -3,  5,       4
      values  2, -3, -5,      -6
      values -2,  3,  5,       6
      values -2,  3, -5,      -4
      values -2, -3,  5,       0
      values -2, -3, -5,     -10

Now you can clearly see that you've tested every combination.

## Usage

The first example above shows just about everything. Use `outline` to define a
spec outline, `fields` to declare the variables, and `values` to create an
example with the given values bound to those variables.

There are some tricks you can play with `outline`, however.

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

    outline "should return the sum (:#)" do
      ...
    end

Will produce names:

    should return the sum (1)
    should return the sum (2)
    should return the sum (3)
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
logic to compute the spec descriptions. Oh, the freedom!

## Contributing

 * [Bug reports](https://github.com/oggy/rspec_outlines/issues)
 * [Source](https://github.com/oggy/rspec_outlines)
 * Patches: Fork on Github, send pull request.
   * Include tests where practical.
   * Leave the version alone, or bump it in a separate commit.

## Copyright

Copyright (c) George Ogata. See LICENSE for details.
