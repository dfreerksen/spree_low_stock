Spree::Variant.class_eval do
  def low_stock?
    quantity = Spree::Config.low_stock_threshold
    Spree::Stock::Quantifier.new(self).low_stock?(quantity)
  end
end
