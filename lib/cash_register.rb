require 'pry'

class CashRegister
  @@transactions = []

  attr_accessor :total,:items,:discount,:current_transaction

  def initialize(discount = nil)
    @total = 0
    @discount = discount
    @items = []
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
    i = 0
    while i < quantity
      items << title
      i+=1
    end
    most_recent_item = current_transaction[title][price][quantity]
  end

  def apply_discount
    if self.discount != nil
      self.total *= (1 - self.discount/100.00)
      "After the discount, the total comes to $#{self.total.to_i}."
    else
      "There is no discount to apply."
    end
  end

  def void_last_transaction

  end
end

new_transaction = CashRegister.new
new_transaction.add_item('eggs', 2.00)
new_transaction.add_item('milk', 3.00, 2)
new_transaction.add_item('milk', 3.00, 3)
