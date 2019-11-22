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
    true
  end

  def my_any?
    selfitem = self
    selfitem.my_each { |x| return true if yield(x) }
    false
  end

  def my_none?
    selfitem = self
    selfitem.my_each { |x| return false if yield(x) }
    true
  end

  def my_count
    array = []
    selfitem = self
    selfitem.my_each { |x| array << x if yield(x) }
    array.length
  end

  def my_map(proc = nil)
    array = []
    selfitem = self
    if proc == true
      selfitem.my_each { |x| array << proc.call(x) }
    else
      selfitem.my_each { |x| array << yield(x) }
    end
    array
  end

  def my_inject(s = 0)
    sum = s
    selfitem = self
    selfitem.my_each { |x| sum = yield(sum, x) }
    sum
  end

  def multiply_els(array)
    array.my_inject(1) { |x, y| x * y }
  end
end
