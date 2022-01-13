class GoogleService
  def self.find_representatives(address)
    content = conn.get("?key=#{ENV['google_key']}&address=#{address}")
    parse_response(content)
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://www.googleapis.com/civicinfo/v2/representatives")
  end
end
