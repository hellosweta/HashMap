require_relative 'p02_hashing'
require_relative 'p04_linked_list'
include Enumerable
class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    if bucket(key).include?(key)
      return true
    end
    false
  end

  def set(key, val)
    if self.include?(key)
      bucket(key).update(key, val)
    else
      if @count == num_buckets
        resize!
      end
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |linked_list|
      linked_list.each do |link|
        yield(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.dup
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |key, val|
      set(key, val)
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
