# simple_linked_list.rb

class Element
  attr_reader :datum
  attr_accessor :next, :previous

  def initialize(datum, next_element=nil)
    @datum = datum
    @next = next_element
    @previous = nil
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_accessor :head

  def initialize
    @list = []
  end

  def self.from_a(input_array)
    list = self.new
    return list if input_array.nil? || input_array == []
    input_array.reverse.each { |datum| list.push(datum) }
    list
  end

  def push(datum)
    element = Element.new(datum, @head)
    @list << element
    @head = element
    @head.next.previous = element if @head.next
  end

  def pop
    element = @head
    @head = element.next
    @list.delete(element)
    element.datum
  end

  def size
    @list.size
  end

  def empty?
    @list.empty?
  end

  def peek
    return nil if self.size.zero?
    @head.datum
  end

  def to_a
    return @list if self.empty?
    @list.map { |element| element.datum }.reverse
  end

  def reverse
    current_element = @head
    until current_element.tail? do 
      current_element = current_element.next 
    end
    @head = current_element
    @list.each { |element| element.next, element.previous = element.previous, element.next }
    @list.reverse!
    self
  end
end
