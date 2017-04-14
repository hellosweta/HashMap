class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0;
    self.each_with_index do |el, idx|
      if el.class == Array
        el.hash
      else
        hashed += (el * idx) % self.length
      end
    end
    hashed
  end
end

class String
  def hash
    hashed = 0;
    self.each_char.with_index do |el, idx|
      hashed += (el.ord * idx) % self.length
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0;
    self.keys.sort.each do |key|
      hashed += key.to_s.ord * self[key].to_s.ord
    end
    hashed
  end
end
