require 'pry'

class CashRegister
  @@transactions = []

  attr_accessor :total,:items,:discount,:current_transaction

  def initialize(discount = nil)
    @total = 0
    @discount = discount
    @current_transaction = {}
  end

  def total
    @total
  end

  def add_item(title, price, quantity = 1)
    puts "${current_transaction}"
  end

  def apply_discount

  end

  def items

  end
end
