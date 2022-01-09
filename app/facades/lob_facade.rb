class LobFacade
  def self.create_letter(letter_data)
    lob = LobService.client

    to_address = lob.addresses.create(letter_data[:to_address])
    from_address = lob.addresses.create(letter_data[:from_address])

    confirmation = lob.letters.create(
                        description: "Test letter",
                        to: to_address["id"],
                        from: from_address["id"],
                        file: html_formatter(letter_data[:letter_body]),
                        merge_variables: { name: 'Albert', event: 'HTML Letter Conference'},
                        metadata: { campaign: 'HTML 1.0' },
                        color: false
                      )
      letter = Letter.create(
      user_id: letter_data[:user_id],
      to_name: confirmation["to"]["name"],
      to_address_line1: confirmation["to"]["address_line1"],
      to_address_line2: confirmation["to"]["address_line2"],
      to_address_city: confirmation["to"]["address_city"],
      to_address_state: confirmation["to"]["address_state"],
      to_address_zip: confirmation["to"]["address_zip"],
      from_name: confirmation["from"]["name"],
      from_address_line1: confirmation["from"]["address_line1"],
      from_address_line2: confirmation["from"]["address_line2"],
      from_address_city: confirmation["from"]["address_city"],
      from_address_state: confirmation["from"]["address_state"],
      from_address_zip: confirmation["from"]["address_zip"],
      body: letter_data[:letter_body],
      send_date: confirmation["send_date"][0..9],
      delivery_date: confirmation["expected_delivery_date"]
    )
  end


  private

      def self.html_formatter(letter_body)
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
