require 'byebug'

class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = (0..max).to_a.map{ |ele| ele=false}
  end

  def insert(num)
    validate!(num)
    # raise "Out of bounds" if !num.between?(0,@store.length-1)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@store.length-1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if !include?(num)
      self[num] << num 
    end 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
    # indexat(num)
  end

  private

  # def indexat(num)


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
    unless include?(num)
      resize! if num_buckets == (count + 1)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
      store_new = Array.new(num_buckets * 2) { Array.new }
      @store.each do |little_bucket|
        little_bucket.each do |ele|
          bk = ele % store_new.length
          store_new[bk] << ele
        end
      end

      @store = store_new
  end
end
