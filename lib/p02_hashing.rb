class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def our_hash
    number = 0.0
    copy = self.dup
    until copy.empty?
      number += copy.shift
      number *= copy.shift unless copy.empty?
      number -= copy.shift unless copy.empty?
      number %= copy.shift unless copy.empty?
      number /= copy.shift unless copy.empty?
    end

    number.hash
  end
end

class String
  def our_hash
    string_arr = []
    self.chars.each do |char|
      string_arr << char.ord
    end
    string_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def our_hash
    hash_array = self.dup.sort
    hash_string = ""
    hash_array.each do |array|
      array.each do |el|
        el = el.is_a?(Symbol) ? el.to_s + "s" : el.to_s
        hash_string << el
      end
    end
    hash_string.hash
  end
end
