require 'byebug'

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
    self.next.prev = self.prev unless @next.nil?
    self.prev.next = self.next unless @prev.nil?
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
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
    each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    link = Link.new(key, val)
    link.prev = @tail.prev
    @tail.prev.next = link
    @tail.prev = link
    link.next = @tail
  end

  def update(key, value)
    each do |link|
      link.val = value if link.key == key
    end
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.remove
        return link
      end
    end
    nil
  end

  def each
    start = @head.next

    until start == @tail
      yield(start)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
