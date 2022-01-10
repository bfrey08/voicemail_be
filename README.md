
# [VoiceMail Back-End](https://github.com/bfrey08/voicemail_be)

[![VoiceMail](https://circleci.com/gh/bfrey08/voicemail_be.svg?style=svg)](https://app.circleci.com/pipelines/github/bfrey08/voicemail_be)

#### [VoiceMail Front-End](https://github.com/GregoryJFischer/voicemail_fe)

## Table of contents
- [Overview](#overview)
- [Setup](#setup)
- [Schema](#schema)
- [Project Board](#project-board)
- [API](#api)
- [Endpoints](#endpoints)
- [Technologies](#technologies)
- [Contributors](#contributors)

## <ins>Overview</ins>

# VoiceMail
Tackling the limitations of emailing legislators to share your opinion. Create a platform for finding, and then meaningfully influencing representatives via physical mail.

-Insert completed feature details here-

This project was based off Turing's consultancy project. More details can be found [here](https://backend.turing.edu/module3/projects/consultancy/project_goals)

### <ins>Setup</ins>
1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Set-up Figaro: ``
3. Setup the database: `rails db:{drop,create,migrate}`
4. Run `bundle exec rspec` to test

### <ins>API Setup</ins>
1. Set-up Figaro: `bundle exec figaro install`
2. Navigate to /config/application.yml
3. Paste following code and replace the following 'YOUR-API-KEY' with an active API key
  ```
  LOB_TEST_API_KEY: 'YOUR-API-KEY'
  LOB_LIVE_API_KEY: 'YOUR-API-KEY'
  google_key: 'YOUR-API-KEY'
  ```

### <ins>Schema</ins>


### <ins>Project Board</ins>
[User-Stories](https://trello.com/b/6B39kgSb/consultancy-project)

### <ins>Endpoints</ins>

### <ins>Technologies</ins>

#### Versions
- Ruby 2.7.2
- Rails 5.2.5

#### Development
![Atom][Atom-img]
![Figaro][Figaro-img]
![Git][Git-img]
![Github][Github-img]
![Markdown][Markdown-img]
![PostgreSQL][PostgreSQL-img]
![Postman][Postman-img]
![Rubocop][Rubocop-img]
![Ruby on Rails][Ruby on Rails-img]

#### Languages
![ActiveRecord][ActiveRecord-img]
![Ruby][Ruby-img]

#### Deployment
![Heroku][Heroku-img]
![Circle Ci][Circle Ci-img]
![Faraday][Faraday-img]

#### Testing
![Capybara][Capybara-img]
![Launchy][Launchy-img]
![Pry][Pry-img]
![RSPEC][RSPEC-img]
![Shoulda Matchers][Shoulda Matchers-img]
![Simplecov][Simplecov-img]
![VCR][VCR-img]
![Webmock][Webmock-img]

#### Development Principles
![OOP][OOP-img]
![TDD][TDD-img]
![MVC][MVC-img]
![REST][REST-img]

### <ins>Contributors</ins>
![LinkedIn][LinkedIn-img]
- [Christina Delpone](https://www.linkedin.com/in/christinadelpone)
- [Billy Frey](https://www.linkedin.com/in/william-frey/)
- [Alex McConnell](https://www.linkedin.com/in/alex-m-mcconnell/)
- [Nate Brown](https://www.linkedin.com/in/nathanbrownco/)
- [Gregory Fischer](https://www.linkedin.com/in/gregoryjfischer/)

![Github][Github-img]
- [Christina Delpone](https://github.com/cdelpone)
- [Billy Frey](https://github.com/bfrey08)
- [Alex McConnell](https://github.com/AlexMMcConnell)
- [Nate Brown](https://github.com/yosoynatebrown)
- [Gregory Fischer](https://github.com/GregoryJFischer)


<!-- Markdown link & img dfn's -->
[travis-image]: https://app.travis-ci.com/TannerDale/bones-be.svg?branch=main
[travis-url]: https://app.travis-ci.com/TannerDale/bones-be
[Github-img]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white

<!-- #### Development -->
[Atom-img]: https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white
[Bootstrap-img]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Figaro-img]: https://img.shields.io/badge/figaro-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Git-img]: https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white
[Github-img]: https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white
[Markdown-img]: https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white
[PostgreSQL-img]: https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white
[Postman-img]: https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white
[Rubocop-img]: https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Ruby on Rails-img]: https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white

<!-- #### Languages -->
[ActiveRecord-img]: https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white
[CSS3-img]: https://img.shields.io/badge/CSS3-1572B6.svg?&style=flaste&logo=css3&logoColor=white
[HTML5-img]: https://img.shields.io/badge/HTML5-0EB201.svg?&style=flaste&logo=html5&logoColor=white
[Ruby-img]: https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white

<!-- #### Deployment -->
[Heroku-img]: https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white
[Circle CI-img]: https://img.shields.io/badge/-CircleCi-brightgreen.svg?logo=LOGO
[Faraday-img]: https://img.shields.io/badge/faraday-b81818.svg?&style=flaste&logo=rubygems&logoColor=white

<!-- #### Testing -->
[Capybara-img]: https://img.shields.io/badge/capybara-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Launchy-img]: https://img.shields.io/badge/launchy-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Pry-img]: https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[RSPEC-img]: https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Shoulda Matchers-img]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Simplecov-img]: https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[VCR-img]: https://img.shields.io/badge/vcr-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Webmock-img]: https://img.shields.io/badge/webmock-b81818.svg?&style=flaste&logo=rubygems&logoColor=white

<!-- #### Development Principles -->
[OOP-img]: https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white
[TDD-img]: https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white
[MVC-img]: https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white
[REST-img]: https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white

<!-- ### <ins>Contributors</ins> -->
[LinkedIn-img]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
