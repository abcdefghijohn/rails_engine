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
    Merchant.create!(name: 'Jim Bob')
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
