class Player
  attr_accessor :symbol, :name
  def intialize(name = nil, symbol = nil )
    @name = name
    @symbol = symbol
  end
end
