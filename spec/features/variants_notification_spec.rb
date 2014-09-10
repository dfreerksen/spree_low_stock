require 'spec_helper'

feature 'Product variant stock' do
  let!(:product)        { create(:product) }
  let!(:variant)        { create(:variant, product: product) }
  let!(:stock_location) { create(:stock_location) }

  let(:product_path)      { spree.product_path(product) }
  let(:low_stock_element) { '#product-variants li .low-stock.variation' }

  subject { variant }

  before { Spree::Config.low_stock_threshold = 5 }

  context 'when above threshold' do
    before { subject.update_attributes!(track_inventory: true) }

    it 'does not show notification' do
      visit product_path
      expect(page).to_not have_css(low_stock_element)
    end
  end

  context 'when below threshold' do
    context 'and stock is not tracked' do
      before { subject.update_attributes!(track_inventory: false) }

      it 'does not notify of low stock' do
        visit product_path
        expect(page).to_not have_css(low_stock_element)
      end
    end

    context 'and stock is tracked' do
      before { subject.update_attributes!(track_inventory: true) }

      context 'does not notify' do
        it 'when current stock is 0' do
          subject.stock_items.first.update_column(:count_on_hand, 0)
          visit product_path
          expect(page).to_not have_css(low_stock_element)
        end
      end

      context 'notifies' do
        it 'when low stock' do
          subject.stock_items.first.update_column(:count_on_hand, 4)
          visit product_path
          expect(page).to have_css(low_stock_element)
          within(low_stock_element) do
            expect(page).to(
              have_content(Spree.t('lowstock.notification', count: 4))
            )
          end
        end
      end
    end
  end
end
