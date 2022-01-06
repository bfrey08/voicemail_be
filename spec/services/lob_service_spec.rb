require 'rails_helper'

describe LobService do
  it 'can make a new lob object' do
    lob = LobService.client

    expect(lob).to be_an_instance_of(Lob::Client)
  end


end
