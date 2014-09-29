# Spree Low Stock

http://groundctrl.github.io/spree_low_stock/

Low stock notification for products and product variations.

> Still under development. Not ready for production.


## Threshold

The low stock threshold is an integer representing how far the current stock of a product has to drop before notifications become visible on the page.

#### Default

Default threshold is `5`. If stock for a product is `6` or above, low threshold notification will not be visible on the page. When the stock for that product drops to `5`, the low stock notification will be visible.

#### Zero

Low stock notifications are considered inactive if the threshold is set to less than or equal to `0`. When product stock drops to zero, the product is considered out of stock rather than being low on stock. Anything less than `1` will make the threshold notification inactive.

#### Non-numeric value

The low stock threshold requires an integer. In the admin, setting the low stock threshold to `five` will result in the low stock threshold being set to `0`.

Setting the low stock threshold to `a2` (string beginning with non-number) will result in the low stock threshold being set to `0`.

Setting the low stock threshold to `2a` (string beginning with a number followed by non-number) will result in the low stock threshold being set to `2`.


## Installation

Add this line to your Spree application's Gemfile:

    gem 'spree_low_stock', github: 'groundctrl/spree_low_stock'

Run the bundle command to install it:

    bundle install

After installing, you'll need to run the generator:

    bundle exec rails g spree_low_stock:install


## Testing

Generate a dummy application

    bundle exec rake test_app

Running tests

    bundle exec rake spec


## Contributing

1. Fork it ( https://github.com/groundctrl/spree_low_stock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
