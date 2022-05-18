class LobFacade
  def self.verify_address(address)
    lob = LobService.verification_client

    verification = lob.us_verifications.verify(
      city: address[:address_city],
      state: address[:address_state],
      primary_line: address[:address_line1],
      secondary_line: address[:address_line2],
      zip_code: address[:address_zip]
    )

    verification['deliverability'] == 'deliverable'
  end

  def self.create_letter(letter_data)
    user = User.find(letter_data[:user_id])
    
    letter = Letter.create(
      user_id: user.id,
      to_name: letter_data[:to_address][:name],
      from_name: letter_data[:from_address][:name],
      body: letter_data[:letter_body],
      to: to_address(letter_data),
      from: user.address
    )
    letter
  end

  def self.send_letter(user_email)
    lob = LobService.client
    user = User.find_by(email: user_email)

    letter = user.letters.order(:created_at).last
    to_address = Address.find(letter.to_id)

    letter_data = {
      to_address: {
                    name: letter.to_name,
                    address_country: "US", 
      }.merge(to_address.address_hash),
      from_address: {
                      name: letter.from_name,
                      address_country: "US"
      }.merge(user.address_hash),
      letter_body: letter.body,
      user_id: user.id}
  
    to_address = lob.addresses.create(letter_data[:to_address])
    from_address = lob.addresses.create(letter_data[:from_address])

    confirmation = lob.letters.create(
      description: 'Test letter',
      to: to_address['id'],
      from: from_address['id'],
      file: html_formatter(letter_data[:letter_body]),
      merge_variables: { name: 'Albert', event: 'HTML Letter Conference' },
      metadata: { campaign: 'HTML 1.0' },
      color: false
    )
    letter.update(
      send_date: confirmation['send_date'][0..9],
      delivery_date: confirmation['expected_delivery_date'],
      preview_url: confirmation['url']
    )
    letter
  end

  def self.preview(letter_data)
    lob = LobService.test_client
    user = User.find(letter_data[:user_id])

    letter = Letter.new(
      user_id: user.id,
      to_name: letter_data[:to_address][:name],
      from_name: letter_data[:from_address][:name],
      body: letter_data[:letter_body],
      to: to_address(letter_data),
      from: user.address
    )
    if letter.save
      to_address = lob.addresses.create(letter_data[:to_address])
      from_address = lob.addresses.create(letter_data[:from_address])

      confirmation = lob.letters.create(
        description: 'Test letter',
        to: to_address['id'],
        from: from_address['id'],
        file: html_formatter(letter_data[:letter_body]),
        merge_variables: { name: 'Albert', event: 'HTML Letter Conference' },
        metadata: { campaign: 'HTML 1.0' },
        color: false
      )
      letter.update(
        send_date: confirmation['send_date'][0..9],
        delivery_date: confirmation['expected_delivery_date'],
        preview_url: confirmation['url']
      )
    end
    letter
  end

  private
    def self.to_address(letter_data)
      Address.create!(
        address_line1: letter_data[:to_address][:address_line1],
        address_line2: letter_data[:to_address][:address_line2],
        address_city: letter_data[:to_address][:address_city],
        address_state: letter_data[:to_address][:address_state],
        address_zip: letter_data[:to_address][:address_zip]
      )
    end

    def self.html_formatter(letter_body)
      letter_body.gsub!("\n", '<br>')

      html = %{
                <html>

  <head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css?family=Tinos" rel="stylesheet" type="text/css">
    <title>Letter to Representative</title>
    <style>
      *,
      *:before,
      *:after {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
      }

      body {
        width: 8.5in;
        height: 11in;
        margin: 0;
        padding: 0;
      }

      .page {
        page-break-after: always;
        position: relative;
        width: 8.5in;
        height: 11in;
      }

      .page-content {
        position: absolute;
        width: 8.125in;
        height: 10.625in;
        left: 0.1875in;
        top: 0.1875in;
        background-color: rgba(0, 0, 0, 0);
      }

      .text {
        margin-left: 55px;
        margin-right: 55px;
        margin-top: 300px;
        font-family: 'Tinos';
        font-size: 10pt;
        line-height: 14pt;
      }

      .red-text {
        color: red;
      }

      .date {
        float: right;
      }

      #return-address-window {
        position: absolute;
        left: .625in;
        top: .5in;
        width: 3.25in;
        height: .875in;
        background-color: rgba(255, 0, 0, 0);
      }

      #return-address-text {
        position: absolute;
        left: .07in;
        top: .34in;
        width: 2.05in;
        height: .44in;
        font-size: .11in;
      }
      /* your main logo should have dimensions of 240x224 pixels. */

      #main-logo {
        position: absolute;
        left: 542px;
        top: 23px;
        width: 2in;
        height: .3in;
      }

      #recipient-address-window {
        position: absolute;
        left: .625in;
        top: 1.7in;
        width: 4in;
        height: 1in;
        background-color: rgba(255, 0, 0, 0);
      }

      #recipient-address-text {
        position: absolute;
        left: .07in;
        top: .05in;
        width: 2.92in;
        height: .9in;
      }

      #white-box {
        background-color: white;
        width: 3.15in;
        height: 2in;
        position: absolute;
        left: .6in;
        top: .84in;
      }
    </style>
  </head>

  <body>
    <div class="page">
      <div class="page-content">
      <!-- <div id="main-logo"><img src="https://s3.us-west-2.amazonaws.com/public.lob.com/Lob_For_Good/voter+access+program+(1).png" width="240px"></div> -->
        <div class="text">
          #{letter_body}
        </div>

        <!-- This div represents a white box which will be printed on top of all artwork to hold address and barcode information. Any content provided underneath this area will be covered. -->
        <div id="white-box"></div>

        <div id="return-address-window">
          <div id="return-address-text">
          </div>
        </div>
        <div id="recipient-address-window">
          <div id="recipient-address-text">
          </div>
        </div>
      </div>

  </body>

  </html>
                }
    end
end
