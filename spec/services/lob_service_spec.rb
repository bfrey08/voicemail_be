require 'rails_helper'

describe LobService do
  it 'can make a new lob object' do
    lob = LobService.client
    lob2 = LobService.verification_client

    expect(lob).to be_an_instance_of(Lob::Client)
    expect(lob2).to be_an_instance_of(Lob::Client)
  end
end
