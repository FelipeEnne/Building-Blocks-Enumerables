# frozen_string_literal: true

# rubocop: disable Metrics/CyclomaticComplexity

# rubocop: disable Metrics/PerceivedComplexity

# rubocop: disable Metrics/ModuleLength

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

  def my_all?(defualt = nil)
    selfitem = self
    if !block_given? && defualt.nil?
      selfitem.my_each { |x| return false unless x }
    elsif defualt.is_a? Regexp
      selfitem.my_each { |x| return false unless x =~ defualt }
    elsif block_given?
      selfitem.my_each { |x| return false unless yield(x) }
    else
      selfitem.my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(defualt = nil)
    selfitem = self
    if !block_given? && defualt.nil?
      selfitem.my_each { |x| return true if x }
    elsif defualt.is_a? Regexp
      selfitem.my_each { |x| return true if x =~ defualt }
    elsif block_given?
      selfitem.my_each { |x| return true if yield(x) }
    else
      selfitem.my_each { |x| return true if x }
    end
    false
  end

  def my_none?(defualt = nil)
    selfitem = self
    if !block_given? && defualt.nil?
      selfitem.my_each { |x| return false if x }
    elsif defualt.is_a? Regexp
      selfitem.my_each { |x| return false if x =~ defualt }
    elsif block_given?
      selfitem.my_each { |x| return false if yield(x) }
    else
      selfitem.my_each { |x| return false if x }
    end
    true
  end

  def my_count(defualt = nil)
    return length unless block_given? || !defualt.nil?

    array = []
    counter = 0
    selfitem = self
    if !defualt.nil?
      selfitem.my_each { |x| counter += 1 if x == defualt }
      counter
    else
      selfitem.my_each { |x| array << x if yield(x) }
      cont = array.length
      cont
    end
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

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
    if block_given?
      arr = to_a
      sum = args[0].nil? ? my_arr[0] : args[0]
      arr.shift if args[0].nil?
      arr.each { |x| sum = yield(sum, x) }
    else
      sum = selfitem[0]
      selfitem[1..-1].my_each { |x| sum = yield(sum, x) }
    end
    sum
  end

  def multiply_els(array)
    array.my_inject(1) { |x, y| x * y }
  end
end

# rubocop: enable Metrics/CyclomaticComplexity

# rubocop: enable Metrics/PerceivedComplexity

# rubocop: enable Metrics/ModuleLength