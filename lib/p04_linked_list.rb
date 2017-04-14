include Enumerable
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    prev_next = @next
    @next.prev = @prev
    @prev.next = prev_next
  end
end

class LinkedList
  def initialize
    @head = Link.new(0, nil)
    @tail = Link.new(1, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    unless @head.next == @tail
      return @head.next
    end
    nil
  end

  def last
    unless @tail.prev == @head
      return @tail.prev
    end
    nil
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_link = @head.next
    while current_link != @tail
      return current_link.val if current_link.key == key
      current_link = current_link.next
    end
    nil
  end

  def include?(key)
    self.each do |link|
      if link.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key,val)
    last_link = @tail.prev
    @tail.prev = new_link
    last_link.next = new_link
    new_link.next = @tail
    new_link.prev = last_link
  end

  def update(key, val)
    if self.include?(key)
      self.remove(key)
      self.append(key,val)
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove
      end
    end
  end

  def each
    current_link = @head.next
    while current_link != @tail
      yield(current_link)
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
