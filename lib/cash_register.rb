require 'pry'

class CashRegister
  @@transactions = []

  attr_accessor :total,:items,:discount,:current_transaction

  def initialize(discount = nil)
    @total = 0
    @discount = discount
    @items = []
    @current_transaction = {}
  end

  def total
    if self.current_transaction != {}
      current_total = current_transaction.collect do |items, prices|
        prices.collect {|price, quantity| price * quantity}
      end
      @total = current_total.flatten.inject(:+)
    else
      @total
    end
  end

  def add_item(title, price, quantity = 1)
    if current_transaction.has_key?(title)
      if current_transaction[title].has_key?(price)
        current_transaction[title][price]+=quantity
      end
    else
      current_transaction[title] = {price=>quantity}
    end
    self.total
    i = 0
    while i < quantity
      items << title
      i+=1
    end
    @@transactions << [title,price,quantity]
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
    self.current_transaction[@@transactions[-1][0]][@@transactions[-1][1]] -= [@@transactions[-1][2]].inject(0.00,:+)

  end
end

new_transaction = CashRegister.new(20)
new_transaction.add_item('apple laptop',1000.00)
new_transaction.apply_discount
new_transaction.void_last_transaction
