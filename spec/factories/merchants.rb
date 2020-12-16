# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end
