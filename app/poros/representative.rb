class Representative
  attr_reader :id,
              :name,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip 

  def initialize(rep)
    @name = rep[:name]
    @address_line1 = rep[:address][0][:line1]
    @address_city  = rep[:address][0][:city]
    @address_state = rep[:address][0][:state]
    @address_zip   = rep[:address][0][:zip]
  end
  
  def set_id(integer)
    @id = integer
  end
end
