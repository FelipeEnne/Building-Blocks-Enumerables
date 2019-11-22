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
    selfitem = self
    selfitem.my_each { |x| array << x if yield(x) }
    array
  end

  def my_all?
    selfitem = self
    selfitem.my_each { |x| return false unless yield(x) }
    return true
  end

  def my_any?
    selfitem = self
    selfitem.my_each { |x| return true if yield(x) }
    return false
  end

  def my_none?
    selfitem = self
    selfitem.my_each { |x| return false if yield(x) }
    return true
  end

  def my_count
    array = []
    selfitem = self
    selfitem.my_each { |x| array << x if yield(x) }
    return array.length
  end

  def my_map(proc = nil)
    array = []
    selfitem = self
    if proc == true
      selfitem.my_each { |x| array << proc.call(x) }
    else
      selfitem.my_each { |x| array << yield(x) }
    end
    return array
  end

  def my_inject(s = 0)
    array = []
    sum = s
    selfitem = self
    selfitem.my_each { |x| sum = yield(sum, x) }
    return sum
  end

  def multiply_els(array)
    array.my_inject(1) { |x, y| x * y }
  end
end

# test
include Enumerable
array1 = [1, 2, 3, 4, 5]
array2 = [1, 1, 2, 2, 2]
testproc = proc { |x| x * x }

# my_map
print "my_map output\:"
print array1.my_map { |x| x * x }
print " / "
print array1.my_map(&testproc)
puts " "

print "map output\:"
print array1.map { |x| x * x }
print " / "
print array1.map(&testproc)
puts " "

# my_inject
print "my_inject output\: "
print array1.my_inject { |sum, n| sum + n }
puts " "

print "inject output\: "
print array1.inject { |sum, n| sum + n }
puts " "

print "multiply_els output\:"
print multiply_els([2, 4, 5])
puts " "
