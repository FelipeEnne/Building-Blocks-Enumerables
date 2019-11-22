# frozen_string_literal: true

module Enumerable
  def my_each
    x = 0
    selfitem = self
    while x < selfitem.size
      yield(selfitem[x])
      x += 1
    end
  end

  def my_each_with_index
    x = 0
    selfitem = self
    while x < selfitem.size
      yield(selfitem[x], x)
      x += 1
    end
  end

  def my_select
    array = []
    self.my_each { |x| array << x if yield(x) }
    return array
  end

  def my_all?
    self.my_each { |x| return false if !yield(x) }
    return true
  end

  def my_any?
    self.my_each { |x| return true if yield(x) }
    return false
  end

  def my_none?
    self.my_each { |x| return false if yield(x) }
    return true
  end

  def my_count
    array = []
    self.my_each { |x| array << x if yield(x) }
    return array.length
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

# my_each_with_index
print "my_each_with_index output\: "
array1.my_each_with_index { |item| print item }
puts " "
print "each_with_index output\: "
array1.each_with_index { |item| print item }
puts " "

# my_select
print "my_select output\: "
print array1.my_select { |item| item > 2 }
puts " "
print "select output\: "
print array1.select { |item| item > 2 }
puts " "

# my_all?
print "my_all? output\: "
print array1.my_all? {|number| number > 5}
print " / "
print array1.my_all? {|number| number <= 5}
puts " "

print "all? output\: "
print array1.all? {|number| number > 5}
print " / "
print array1.all? {|number| number <= 5}
puts " "

# my_any?
print "my_any? output\: "
print array1.my_any? {|number| number > 5}
print " / "
print array1.my_any? {|number| number >= 5}
puts " "

print "any? output\: "
print array1.any? {|number| number > 5}
print " / "
print array1.any? {|number| number >= 5}
puts " "


# my_none?
print "my_none? output\: "
print array1.my_none? {|number| number > 5}
print " / "
print array1.my_none? {|number| number >= 5}
puts " "

print "none? output\: "
print array1.none? {|number| number > 5}
print " / "
print array1.none? {|number| number >= 5}
puts " "


# my_count
print "my_count output\: "
print array1.my_count {|number| number == 2}
print " / "
print array2.my_count {|number| number == 2}
puts " "

print "count output\: "
print array1.count {|number| number == 2}
print " / "
print array2.count {|number| number == 2}
puts " "
=end
