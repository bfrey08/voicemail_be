class Representative
  attr_reader :name,
              :address

  def initialize(rep)
    @name = rep[:name]
    # @street_address_1 = rep[:address][0][:line1]
    @address = full_address(rep[:address])
  end

  def full_address(address)
    address.first.values.join(', ')
  end
end
