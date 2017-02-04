require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    # debugger
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      @count += 1
      bucket(key).append(key, val)
    end
  end

  def get(key)
    # debugger
    bucket(key).get(key)
  end

  def delete(key)
    if bucket(key).include?(key)
      @count -= 1
      bucket(key).remove(key)
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
    copy = @store.dup

    @store = Array.new(num_buckets * 2) { LinkedList.new }

    copy.each do |linked_list|
      linked_list.each do |link|
        bucket(link.key).append(link.key, link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
