class Transaction < ApplicationRecord
  belongs_to :invoice, dependent: :destroy
end
