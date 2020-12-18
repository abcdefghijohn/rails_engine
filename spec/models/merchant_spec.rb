# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe 'class methods' do
    before :each do
      @customer_1 = Customer.create!(first_name: 'Customer', last_name: 'One')
      @customer_2 = Customer.create!(first_name: 'Customer', last_name: 'Two')
      @customer_3 = Customer.create!(first_name: 'Customer', last_name: 'Three')
      @customer_4 = Customer.create!(first_name: 'Customer', last_name: 'Four')
      @merchant_1 = Merchant.create!(name: 'First')
      @merchant_2 = Merchant.create!(name: 'Second')
      @merchant_3 = Merchant.create!(name: 'Third')
      @merchant_4 = Merchant.create!(name: 'Fourth')
      @id = @merchant_3.id
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1000)
      @item_2 = create(:item, merchant: @merchant_2, unit_price: 100)
      @item_3 = create(:item, merchant: @merchant_3, unit_price: 10)
      @item_4 = create(:item, merchant: @merchant_4, unit_price: 1)
      @invoice_1 = @merchant_1.invoices.create!(customer: @customer_1, status: 'shipped', created_at: 'Tue, 01 Dec 2020 00:00:00 UTC +00:00')
      @invoice_2 = @merchant_2.invoices.create!(customer: @customer_2, status: 'shipped', created_at: 'Wed, 02 Dec 2020 00:00:00 UTC +00:00')
      @invoice_3 = @merchant_3.invoices.create!(customer: @customer_3, status: 'shipped', created_at: 'Tue, 01 Dec 2020 00:00:00 UTC +00:00')
      @invoice_4 = @merchant_4.invoices.create!(customer: @customer_4, status: 'shipped', created_at: 'Tue, 03 Nov 2020 00:00:00 UTC +00:00')
      @invoice_1.invoice_items.create(item: @item_1, quantity: 1, unit_price: 1000)
      @invoice_2.invoice_items.create(item: @item_2, quantity: 2, unit_price: 100)
      @invoice_3.invoice_items.create(item: @item_3, quantity: 3, unit_price: 10)
      @invoice_4.invoice_items.create(item: @item_4, quantity: 4, unit_price: 1)
      @invoice_1.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/22)
      @invoice_2.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/20)
      @invoice_3.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/20)
      @invoice_4.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/20)
    end

    it '.most_revenue()' do
      merchants = Merchant.most_revenue(3)

      expect(merchants.to_a.count).to eq(3)
      expect(merchants.first[:id]).to eq(@merchant_1.id)
      expect(merchants.last[:id]).to eq(@merchant_3.id)
    end

    it '.most_items()' do
      merchants = Merchant.most_items(2)

      expect(merchants.to_a.count).to eq(2)
      expect(merchants.first[:id]).to eq(@merchant_4.id)
      expect(merchants.last[:id]).to eq(@merchant_3.id)
    end

    it '.revenue()' do
      revenue_1 = Merchant.revenue(@merchant_1.id)
      revenue_2 = Merchant.revenue(@merchant_2.id)
      revenue_3 = Merchant.revenue(@merchant_3.id)
      revenue_4 = Merchant.revenue(@merchant_4.id)

      expect(revenue_1[0][:revenue]).to eq(1000.0)
      expect(revenue_2[0][:revenue]).to eq(200.0)
      expect(revenue_3[0][:revenue]).to eq(30.0)
      expect(revenue_4[0][:revenue]).to eq(4.0)
    end
  end
end
