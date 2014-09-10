describe Spree::Variant do
  context '#low_stock?' do
    let!(:product)        { create(:product) }
    let!(:stock_location) { create(:stock_location) }

    let(:product_path) { spree.product_path(product) }

    before { Spree::Config.low_stock_threshold = 5 }

    context 'for product without variants' do
      subject { product.master }

      context 'stock is not tracked' do
        before { subject.update_attributes!(track_inventory: false) }

        it 'return `false` ' do
          expect(subject.low_stock?).to be_falsey
        end
      end

      context 'stock is tracked' do
        before { subject.update_attributes!(track_inventory: true) }

        it 'return `false` when product stock is 0' do
          subject.stock_items.first.update_column(:count_on_hand, 0)
          expect(subject.low_stock?).to be_falsey
        end

        it 'return `false` when product stock is not low' do
          subject.stock_items.first.update_column(:count_on_hand, 6)
          expect(subject.low_stock?).to be_falsey
        end

        it 'return `true` when product stock is low' do
          subject.stock_items.first.update_column(:count_on_hand, 5)
          expect(subject.low_stock?).to be_truthy
        end
      end
    end

    context 'for product with variants' do
      let!(:variant) { create(:variant, product: product) }

      subject { variant }

      context 'variant stock is not tracked' do
        before { subject.update_attributes!(track_inventory: false) }

        it 'return `false` ' do
          expect(subject.low_stock?).to be_falsey
        end
      end

      context 'variant stock is tracked' do
        before { subject.update_attributes!(track_inventory: true) }

        it 'return `false` when product stock is 0' do
          subject.stock_items.first.update_column(:count_on_hand, 0)
          expect(subject.low_stock?).to be_falsey
        end

        it 'return `false` when product stock is not low' do
          subject.stock_items.first.update_column(:count_on_hand, 6)
          expect(subject.low_stock?).to be_falsey
        end

        it 'return `true` when product stock is low' do
          subject.stock_items.first.update_column(:count_on_hand, 5)
          expect(subject.low_stock?).to be_truthy
        end
      end
    end
  end
end
