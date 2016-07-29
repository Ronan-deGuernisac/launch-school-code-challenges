# simple_linked_list.rb

class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum, next_element=nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_accessor :head
  attr_reader :size

  def initialize
    @size = 0
  end

  def push(datum)
    @head = Element.new(datum, @head)
    @size += 1
  end

  def pop
    datum = @head.datum
    @head.tail? ? @head = nil : @head = @head.next
    @size -= 1
    datum
  end

  def peek
    return nil if self.empty?
    @head.datum
  end

  def empty?
    self.size == 0
  end

  def reverse
    new_head = @head
    new_head = new_head.next until new_head.tail?
    current_element = new_head
    current_position = self.size
    until current_position == 1
      current_element.next = previous_element(current_position - 1)
      current_element = current_element.next
      current_position -= 1
    end
    @head.next = nil
    @head = new_head
    self
  end

  def previous_element(position)
    current_element = @head
    counter = 1
    until counter == position
      current_element = current_element.next
      counter +=1
    end
    current_element
  end

  def to_a
    arr = []
    current_element = @head
    until current_element.nil? do
      arr << current_element.datum
      current_element = current_element.next
    end
    arr
  end

  def self.from_a(input)
    list = self.new
    input.reverse.each { |datum| list.push(datum) } unless input.nil?
    list
  end
end

# class Element
#   attr_reader :datum
#   attr_accessor :next, :previous

#   def initialize(datum, next_element=nil)
#     @datum = datum
#     @next = next_element
#   end

#   def tail?
#     @next.nil?
#   end
# end

# class SimpleLinkedList
#   attr_accessor :head

#   def initialize
#     @list = []
#   end

#   def self.from_a(input_array)
#     list = self.new
#     return list if input_array.nil? || input_array == []
#     input_array.reverse.each { |datum| list.push(datum) }
#     list
#   end

#   def push(datum)
#     element = Element.new(datum, @head)
#     @list << element
#     @head = element
#     @head.next.previous = element if @head.next
#   end

#   def pop
#     element = @head
#     @head = element.next
#     @list.delete(element)
#     element.datum
#   end

#   def size
#     @list.size
#   end

#   def empty?
#     @list.empty?
#   end

#   def peek
#     return nil if self.empty?
#     @head.datum
#   end

#   def to_a
#     return @list if self.empty?
#     @list.map { |element| element.datum }.reverse
#   end

#   def reverse
#     current_element = @head
#     until current_element.tail? do 
#       current_element = current_element.next 
#     end
#     @head = current_element
#     @list.each { |element| element.next, element.previous = element.previous, element.next }
#     @list.reverse!
#     self
#   end
# end
