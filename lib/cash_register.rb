require 'pry'

class CashRegister
  attr_accessor :total, :discount, :shopping_cart, :items

    def initialize(discount = nil)
      @discount = discount || 0
      @total = 0
      @shopping_cart ||= {}
      @items = []
    end

    def total
      @total
    end

    def discount
      @discount
    end

    def items
      @items
    end

    def add_item(title,price, quantity = 1)
      i = 1
      while i <= quantity
        self.items << title
        i += 1
      end
      self.shopping_cart[title] ||= {} #creates hash if non-existent
      self.shopping_cart[title][price] = quantity #adds a pricepoint and quantity for the item at that pricepoint
      binding.pry
      self.total = self.shopping_cart.collect {|title, prices| prices.keys[0] * prices.values[0]}.inject(:+) || 0#creates an array of price * quantity for each item and sums them, then updates @total
      self.shopping_cart
    end

    def apply_discount
      if self.discount > 0
        self.total -= self.total * (self.discount * 0.01)
        "After the discount, the total comes to $#{self.total.to_i}."
      else
        "There is no discount to apply."
      end
    end

    def void_last_transaction
      self.shopping_cart.clear
      self.total = 0
    end
end

new_transaction = CashRegister.new
new_transaction.add_item('eggs', 2.00)
new_transaction.add_item('milk', 3.00, 2)
new_transaction.add_item('milk', 2.00, 3)
