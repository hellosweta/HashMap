class MaxIntSet
  def initialize(max)
    @store = Array.new(max + 1) { false }
    @length = @store.length
  end

  def insert(num)
    if num > @length - 1 || num < 0
      raise 'Out of bounds'
    else
      @store[num] = true
      true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self[num].include?(num)
      self[num] << num
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].each do |el|
      if el == num
        return true
      end
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      if @count < num_buckets
        self[num] << num
        @count += 1
      else
        resize!
        self[num] << num
        @count += 1
      end
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].each do |el|
      if el == num
        return true
      end
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@count * 2) { Array.new }
    old_store.each do |arr|
      arr.each do |el|
        @store[el % (@count * 2)] << el
      end
    end
  end
end
