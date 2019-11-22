# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    selfitem = self
    while x < selfitem.size
      yield(selfitem[x])
      x += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    x = 0
    selfitem = self
    while x < selfitem.size
      yield(selfitem[x], x)
      x += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    selfitem = self
    selfitem.my_each { |x| array << x if yield(x) }
    array
  end

  def my_all?
    selfitem = self
    if !block_given?
      selfitem.my_each do |x|
        return true unless x != false && x != nil
      end
    elsif block_given?
      selfitem.my_each { |x| return false unless yield(x) }
    else
      selfitem.my_each { |x| return false unless x }
    end
    true
  end

  def my_any?
    selfitem = self
    if !block_given?
      selfitem.my_each do |x|
        return true if x == true
      end
    elsif block_given?
      selfitem.my_each { |x| return true if yield(x) }
    else
      selfitem.my_each { |x| return true if yield(x) }
    end
    false
  end

  def my_none?
    selfitem = self
    if !block_given?
      selfitem.my_each do |x|
        return false if x == true
      end
    elsif block_given?
      selfitem.my_each { |x| return false if yield(x) }
    else
      selfitem.my_each { |x| return false if x }
    end
    true
  end

  def my_count
    return length unless block_given?

    array = []
    selfitem = self
    selfitem.my_each { |x| array << x if yield(x) }
    cont = array.length
    cont
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

  def my_inject(*args)
    sum = 0
    selfitem = self

    if args.length != 0
      sum = args[0]
      selfitem.my_each { |x| sum = yield(sum, x) }
    else
      sum = selfitem[0]
      selfitem[1..-1].my_each { |x| sum = yield(sum, x) }
    end
  end

  def multiply_els(array)
    array.my_inject(1) { |x, y| x * y }
  end
end
