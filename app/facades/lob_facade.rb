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
              <style>
                *, *:before, *:after {
                  -webkit-box-sizing: border-box;
                  -moz-box-sizing: border-box;
                  box-sizing: border-box;
                }
                @font-face {
                  font-family: 'Loved by the King';
                  font-style: normal;
                  font-weight: 400;
                  src: url('https://s3-us-west-2.amazonaws.com/public.lob.com/fonts/lovedByTheKing/LovedbytheKing.ttf') format('truetype');
                }
                .text {
                  margin-left: 75px;
                  padding-top: 250px;
                  width: 400px;
                  font-family: 'Loved by the King';
                  font-size: 50px;
                  font-weight: 700;
                  color: black;
                }
              </style>
              </head>
              <body>
                <p class="text">"#{letter_body}"</p>
              </body>
              </html>
              }
      end

end
