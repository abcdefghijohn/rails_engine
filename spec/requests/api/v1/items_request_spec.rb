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

describe :finder do
  it 'can find a specific item based on input' do
    create :merchant
    merchant = Merchant.last

    create(:item, name: 'ring pop', merchant: merchant)
    create(:item, name: 'blow pop', merchant: merchant)
    create(:item, name: 'hot pocket', merchant: merchant)

    get '/api/v1/items/find?name=ket'
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    name = item[:data][:attributes][:name].downcase

    expect(item[:data]).to be_a(Hash)
    expect(item.count).to eq(1)
    expect(name).to include('hot')
  end

  it 'can return all items that match input' do
    create :merchant
    merchant = Merchant.last

    create(:item, name: 'ring pop', merchant: merchant)
    create(:item, name: 'blow pop', merchant: merchant)
    create(:item, name: 'hot pocket', merchant: merchant)

    get '/api/v1/items/find_all?name=pop'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    names = items[:data].map do |item|
      item[:attributes][:name].downcase
    end
    expect(names.count).to eq(2)
    names.each do |name|
      expect(name).to include('pop')
    end
  end
end


describe :relationship do
  it 'can return the merchant associated with an item' do
    merchant = create(:merchant, name: 'Jim Bob')
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}/merchants"
    expect(response).to be_successful

    merchant_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(merchant_response[:data][:attributes][:name]).to eq('Jim Bob')
    expect(merchant_response[:data][:id]).to eq(merchant.id.to_s)
  end
end
