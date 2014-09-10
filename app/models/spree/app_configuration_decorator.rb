Spree::AppConfiguration.class_eval do
  preference :low_stock_threshold, :integer, default: 5
end
