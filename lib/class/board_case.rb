class BoardCase
  attr_reader :value

  def initialize
    @value = nil
  end
  def fill(symbol)
    @value = symbol
  end
  def is_full?
    @value != nil
  end
  def is_empty?
    return !is_full?
  end
end