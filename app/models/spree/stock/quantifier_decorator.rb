Spree::Stock::Quantifier.class_eval do
  def low_stock?(required)
    return false unless Spree::Config.track_inventory_levels
    total_on_hand.between?(1, required)
  end
end
