require 'lob'

class LobService
  def self.client
    Lob::Client.new(api_key: ENV['LOB_TEST_API_KEY'])
  end
end
