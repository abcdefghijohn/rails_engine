# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    item_id { nil }
    invoice_id { nil }
    quantity { 1 }
    unit_price { 1.5 }
  end
end
