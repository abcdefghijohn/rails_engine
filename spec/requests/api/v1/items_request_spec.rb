# frozen_string_literal: true

require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create :merchant
    merchant = Merchant.last

    create(:item, merchant: merchant)
    create(:item, merchant: merchant)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(2)
  end

  it 'can find a specific item by id' do
    create :merchant
    merchant = Merchant.last
    id = create(:item, merchant: merchant).id
    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data][:id]).to eq(id.to_s)
  end

  it 'can create an item' do
    create :merchant
    merchant = Merchant.last
    Item.create!(name: 'Chicken Wing',
                 description: "Chillin with ma homies",
                 unit_price: 4,
                 merchant_id: merchant.id)

    post '/api/v1/items'
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq('Chicken Wing')
    expect(item.description).to eq('Chillin with ma homies')
    expect(item.unit_price).to eq(4.0)
  end

  it 'can update an item' do
    create :merchant
    merchant = Merchant.last

    id = create(:item, merchant: merchant).id
    previous_item = Item.last

    patch "/api/v1/items/#{id}", params: { name: 'Macaroni' }
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).not_to eq(previous_item.name)
    expect(item.name).to eq('Macaroni')
  end

  it 'can delete an item' do
    create :merchant
    merchant = Merchant.last

    id = create(:item, merchant: merchant).id
    delete "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
  end
end
