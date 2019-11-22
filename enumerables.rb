# frozen_string_literal: true

module Enumerable

  def my_each
    x = 0
    while x < self.size
      yield(self[x])
      x += 1
    end
  end

  def my_each_with_index
    x = 0
    while x < self.size
      yield(self[x], x)
      x += 1
    end
  end

end

# test
include Enumerable
array1 = [1, 2, 3, 4, 5]
array2 = [1, 1, 2, 2, 2]
testproc = Proc.new { |x| x * x }

=begin
# my_each
print "my_each output\: "
array1.my_each { |item| print item }
puts " "
print "each output\: "
array1.each { |item| print item }
puts " "
=end
# my_each_with_index
print "my_each_with_index output\: "
array1.my_each_with_index { |item| print item }
puts " "
print "each_with_index output\: "
array1.each_with_index { |item| print item }
puts " "
