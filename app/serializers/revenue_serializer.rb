class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  def self.revenue(info)
    {
      "data": {
        "id": nil,
        "attributes": {
          "revenue": info[0][:revenue]
        }
      }
    }
  end
end
