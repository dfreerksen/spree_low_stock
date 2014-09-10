require 'spec_helper'

feature 'General configuration' do
  stub_authorization!

  let(:configuration_path) { spree.edit_admin_general_settings_path }

  context 'low stock threshold form field' do
    {
      # input  => result
      -1     => '-1',
      0      => '0',
      'five' => '0',
      '1a'   => '1',
      'a1'   => '0',
      5      => '5'
    }.each do |input_value, result_value|
      it "accepts `#{input_value}` and results in `#{result_value}`" do
        visit configuration_path
        fill_in 'low_stock_threshold', with: input_value
        click_button(Spree.t('actions.update'))
        expect(find_field('low_stock_threshold').value).to eq(result_value)
      end
    end
  end
end
