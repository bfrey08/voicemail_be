class LettersController < ApplicationController
  def self.create
    lob = LobService.client

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
            <p class="text">Hello {{name}}!<br/><br/>Join us for the {{event}}!</p>
          </body>
          </html>
          }

    to_address = lob.addresses.create(
                                      name: "Burger King",
                                      address_line1: "2110 S Broadway",
                                      address_city: "Denver",
                                      address_state: "CO",
                                      address_country: "US",
                                      address_zip: 80210
                                    )
    from_address = lob.addresses.create(
                                        name: "Wendy's",
                                        address_line1: "515 S Broadway",
                                        address_city: "Denver",
                                        address_state: "CO",
                                        address_country: "US",
                                        address_zip: 80209
                                      )
    lob.letters.create(
                        description: "Test letter",
                        to: to_address["id"],
                        from: from_address["id"],
                        file: html,
                        merge_variables: { name: 'Albert', event: 'HTML Letter Conference'},
                        metadata: { campaign: 'HTML 1.0' },
                        color: false
                      )
  end
end
