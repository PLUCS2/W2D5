class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    answer = 5
    count = 12
    self.each do |ele|
      answer %= (ele.hash + count)
      count += 3
    end
    answer
  end
end

class String
  def hash
    alph = ("a".."z").to_a
    ans = []
    self.split("").each do |letter|
      idx = alph.index(letter)
      ans << [idx].hash
    end
    ans.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted_ha = self.keys.sort 
    sorted_ha += self.values
    sorted_ha.hash
  end
end
