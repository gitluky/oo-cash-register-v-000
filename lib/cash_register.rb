require 'pry'

class CashRegister
  @@transactions = []

  attr_accessor :total,:items,:discount,:current_transaction

  def initialize(discount = nil)
    @total = 0
    @discount = discount
    @current_transaction = {}
    @@transactions << self
  end

  def total
    @total
  end

  def add_item(title, price, quantity = 1)
    if current_transaction.has_key?(title)
      if current_transaction[title].has_key?(price)
        current_transaction[title][price]+=quantity
      end
    else
      current_transaction[title] = {price=>quantity}
    end
    total = current_transaction.collect do |items, prices|
      prices.collect {|price, quantity| price * quantity}
    end
    self.total = total.flatten.inject(:+)
  end

  def apply_discount
    if self.discount <= 0
      self.total *= (1 - self.discount/100.00)
      "After the discount, the total comes to $#{self.total.to_i}."
    end
  end

  def items

  end
end

new_transaction = CashRegister.new
new_transaction.add_item('eggs', 2.00)
new_transaction.add_item('milk', 3.00, 2)
new_transaction.add_item('milk', 3.00, 3)
