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

    else
      @total
    end
  end

  def add_item(title, price, quantity = 1)
    #if item doesn't exist, it'll create a key for the item and a hash {price=>quantity}
    if current_transaction.has_key?(title)
      if current_transaction[title].has_key?(price)
        current_transaction[title][price]+=quantity
      end
    else
      current_transaction[title] = {price=>quantity}
    end
    #updates the total
    current_total = current_transaction.collect do |items, prices|
      prices.collect {|price, quantity| price * quantity}
    end
    @total = current_total.flatten.inject(:+)
    #adds the items to the array the quantity of times entered
    i = 0
    while i < quantity
      items << title
      i+=1
    end
    #adds an array to the @@transactions clas array with title, price and quantity
    @@transactions << [title,price,quantity]
  end

  def apply_discount
    binding.pry
    if self.discount != nil
      @total *= (1 - self.discount/100.00)
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
