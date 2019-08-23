require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  end
end

class LinkedList
  def initialize
    #creates a head node
    @head = Node.new
    @tail = Node.new
    @tail.next = @head
    @head.prev = @tail
    @tail.prev = @head
    @head.next = @tail
  end

  def [](i)
    self.each { |link, j| return link if i == j }
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current = @head.next
    until current.key == key || current == @tail
      current = current.next
    end
    current.val
  end

  def include?(key)
    self.each do |ele|
      if ele.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    if include?(key)
      current = @head.next 
      until current.key == key 
        current = current.next
      end
      current.val = val
    end
  end

  def remove(key)
    current = @head.next 
    until current.key == key 
      current = current.next
    end
    current.next.prev = current.prev
    current.prev.next = current.next
    # current.next = nil
    # current.prev = nil
  end

  def each(&prc)
    start = @head.next
    until start == @tail
      prc.call(start)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
