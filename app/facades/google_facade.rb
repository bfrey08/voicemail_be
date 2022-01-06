class GoogleFacade
  def self.representatives(address)
    representatives = GoogleService.find_representatives(address)[:officials]
    representatives.map do |rep|
      Representative.new(rep)
    end
  end
end
