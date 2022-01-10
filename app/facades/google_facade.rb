class GoogleFacade
  def self.representatives(user_id)
    address = User.find(user_id).full_address

    representatives = GoogleService.find_representatives(address)

    reps = representatives[:officials].map.with_index do |rep, index|
      representative = Representative.new(rep)
      representative.set_id(index)
      representative
    end

    representatives[:offices].each do |office|
      reps.each_with_index do |rep, index|
        if office[:officialIndices].include?(index)
          rep.add_title(office[:name])
        end
      end
    end
    reps
  end
end
