class GoogleService
  def self.find_representatives(address)
    Rails.cache.fetch("#{address}_reps", expires_in: 15.days) do
      content = conn.get("?key=#{ENV['google_key']}&address=#{address}&fields=offices,officials")
      parse_response(content)
    end
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.googleapis.com/civicinfo/v2/representatives')
  end
end
