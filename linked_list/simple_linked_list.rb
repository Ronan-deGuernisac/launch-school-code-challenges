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
    redirect_pointers(new_head)
    @head.next = nil
    @head = new_head
    self
  end

  def redirect_pointers(start)
    current_element = start
    current_position = self.size
    until current_position == 1
      current_element.next = previous_element(current_position - 1)
      current_element = current_element.next
      current_position -= 1
    end
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
