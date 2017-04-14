require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      if @count == num_buckets
        resize!
      end
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].each do |el|
      if el == key
        return true
      end
    end
    false
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(old_store.length * 2) { Array.new }
    old_store.each do |el|
      @store[el.hash % @store.length] << el
    end
    
  end
end
