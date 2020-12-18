# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'class methods' do
    it '.revenue_dates()' do
      customer_1 = Customer.create!(first_name: 'Customer', last_name: 'One')
      customer_2 = Customer.create!(first_name: 'Customer', last_name: 'Two')
      customer_3 = Customer.create!(first_name: 'Customer', last_name: 'Three')
      merchant_1 = Merchant.create!(name: 'First')
      merchant_2 = Merchant.create!(name: 'Second')
      merchant_3 = Merchant.create!(name: 'Third')
      item_1 = create(:item, merchant: merchant_1, unit_price: 1000)
      item_2 = create(:item, merchant: merchant_2, unit_price: 100)
      item_3 = create(:item, merchant: merchant_3, unit_price: 10)
      invoice_1 = merchant_1.invoices.create!(customer: customer_1, status: 'shipped', created_at: 'Tue, 01 Dec 2020 00:00:00 UTC +00:00')
      invoice_2 = merchant_2.invoices.create!(customer: customer_2, status: 'shipped', created_at: 'Wed, 02 Dec 2020 00:00:00 UTC +00:00')
      invoice_3 = merchant_3.invoices.create!(customer: customer_3, status: 'shipped', created_at: 'Tue, 03 Nov 2020 00:00:00 UTC +00:00')
      invoice_1.invoice_items.create(item: item_1, quantity: 1, unit_price: 1000)
      invoice_2.invoice_items.create(item: item_2, quantity: 2, unit_price: 100)
      invoice_3.invoice_items.create(item: item_3, quantity: 3, unit_price: 10)
      invoice_1.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/22)
      invoice_2.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/20)
      invoice_3.transactions.create!(result: 'success', credit_card_number: 123412341234, credit_card_expiration_date: 02/20)

      revenue = Invoice.revenue_dates('2020-12-01', '2020-12-18')

      expect(revenue[0][:revenue]).to be_a(Float)
      expect(revenue[0][:revenue]).to eq(1200.0)
    end
  end
end
