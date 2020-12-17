# frozen_string_literal: true

require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(10)
  end

  it 'can find a specific merchant by id' do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data][:id]).to eq(id.to_s)
  end

  it 'can create a merchant' do
    post '/api/v1/merchants'
    create(:merchant, name: 'Jim Bob')
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq('Jim Bob')
  end

  it 'can update a merchant' do
    id = create(:merchant).id
    Merchant.create!(name: 'Jim Bob')
    previous_merchant = Merchant.last.name
    patch "/api/v1/merchants/#{id}", params: { name: 'Joe Bob' }

    merchant = Merchant.find_by(id: id)
    expect(response).to be_successful
    expect(merchant.name).not_to eq(previous_merchant)
    expect(merchant.name).to eq('Joe Bob')
  end

  it 'can delete a merchant' do
    id = create(:merchant).id
    delete "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
  end
end

  describe 'Finder Endpoints' do
    it 'can find a specific merchant based on input' do
      create(:merchant, name: 'Jim Bob')
      create(:merchant, name: 'Joe Bob')

      get '/api/v1/merchants/find?name=joe'
      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)
      name = merchant[:data][:attributes][:name].downcase

      expect(merchant[:data]).to be_a(Hash)
      expect(merchant.count).to eq(1)
      expect(name).to include('joe')
    end

    it 'can return all merchants that match input' do
      create(:merchant, name: 'Jim Bob')
      create(:merchant, name: 'Joe Bob')
      create(:merchant, name: 'Frank')

      get '/api/v1/merchants/find_all?name=bob'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)
      names = merchants[:data].map do |merchant|
        merchant[:attributes][:name].downcase
      end
      expect(names.count).to eq(2)
      names.each do |name|
      expect(name).to include('bob')
    end
  end

  describe 'Relationships' do
    it 'can return the items associated with a merchant' do
      merchant_1 = create(:merchant, name: 'Jim Bob')
      merchant_2 = create(:merchant, name: 'Joe Bob')
      id_1 = merchant_1.id
      id_2 = merchant_2.id

      create(:item, name: 'ring pop', merchant_id: id_1)
      create(:item, name: 'blow pop', merchant_id: id_2)
      create(:item, name: 'hot pocket', merchant_id: id_1)

      item_1 = Item.first
      item_3 = Item.last

      get "/api/v1/merchants/#{id_1}/items"
      expect(response).to be_successful

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(items_response[:data].count).to eq(2)
      expect(items_response[:data].first[:id]).to eq(item_1.id.to_s)
      expect(items_response[:data].last[:id]).to eq(item_3.id.to_s)
    end
  end
end
