class GoogleFacade
  def self.representatives(address)
    representatives = GoogleService.find_representatives(address)[:officials]
    representatives.map.with_index do |rep, index|
      representative = Representative.new(rep)
      representative.set_id(index)
      representative
    end
  end
end
