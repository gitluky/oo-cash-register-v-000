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
    current_transaction[title] = {}
    binding.pry
    current_transaction[title][price]

    @total = current_transaction.collect {|items| items.key * items.value}.flatten.inject(:+)

  end

  def apply_discount

  end

  def items

  end
end

add_item('eggs', 2.00)
add_item('milk', 3.00, 2)
