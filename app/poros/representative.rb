class Representative
  attr_reader :name,
              :address

  def initialize(rep)
    @name = rep[:name]
    @address = get_address(rep[:address])
  end

  def get_address(address)
    address.first.values.join(', ')
  end
end
