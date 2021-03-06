class Representative
  attr_reader :id,
              :name,
              :title,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip,
              :photo_url

  def initialize(rep)
    @name = rep[:name]
    @photo_url = rep[:photoUrl] if rep[:photoUrl]
    
    if rep[:address]
      @address_line1 = rep[:address][0][:line1]
      @address_city  = rep[:address][0][:city]
      @address_state = rep[:address][0][:state]
      @address_zip   = rep[:address][0][:zip]
    else
      format_address(rep)
    end
  end

  def set_id(integer)
    @id = integer
  end

  def add_title(title)
    @title = title
  end

  def format_address(rep)
    unless rep[:geocodingSummaries][0][:queryString].include?("P.O. Box")
      address = rep[:geocodingSummaries][0][:queryString].split(", ")
      city_zip = address[-1].split(" ")
      address.delete_at(-1)
      address << city_zip
      address.flatten!

      @address_line1 = address[0]
      @address_city  = address[1]
      @address_state = address[2]
      @address_zip   = address[3]
    else
      po_box_format(rep)
    end
  end

  def po_box_format(rep)
    address_with_commas = rep[:geocodingSummaries][0][:queryString]
    address_with_no_commas = address_with_commas.gsub(/[,]/, '')
    address = address_with_no_commas.split(' ')

    @address_line1 = address[0] + ' ' + address[1] + ' ' + address[2]
    @address_city = address[3]
    @address_state = address[4]
    @address_zip = address[5]
  end
end
