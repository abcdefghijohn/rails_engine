# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { 'MyString' }
  end
end
