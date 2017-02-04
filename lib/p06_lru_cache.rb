require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  # def get(key)
  #   if @store.include?(key)
  #     val = @store.get(key)
  #   else
  #     val = calc!(key)
  #   end
  #   new_link = Link.new(key, val)
  #   @map.set(key, new_link)
  #   update_link!(new_link)
  #   val
  # end

  def get(key)
    val = @store.include?(key) ? @store.get(key) : calc!(key)
    update_link!(key, val)
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(key, val)
    @store.remove(key) if @store.include?(key)

    @store.append(key, val)
    @map.set(key, @store.last)

    eject! if count > @max
  end

  # def update_link!(link)
  #   if @store.include?(link.key)
  #     @store.remove(link.key)
  #     @map.delete(link.key)
  #   end
  #   @store.append(link.key, link.val)
  #   eject! if count > @max
  # end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end
