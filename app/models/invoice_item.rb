class InvoiceItem < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :invoice, dependent: :destroy
end
