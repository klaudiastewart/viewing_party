# Viewing Party

Viewing Party is an application that allows users to create a movie share party with their friends. Simply open the application, find a movie you want to watch, add friends to that watch party, and sit back and enjoy the show!

---
## Demo

![d2](https://i.ibb.co/Tgz82qz/Screen-Shot-2021-05-27-at-9-47-24-PM.png)
![d3](https://i.ibb.co/7jfc6dn/Screen-Shot-2021-05-27-at-9-47-45-PM.png)

## Getting Started
Please make sure to include these gems in your Gemfile. Once there, run `bundle` to install and update them.

![GemFile](https://i.ibb.co/4YxRcJB/Screen-Shot-2021-05-19-at-10-05-12-PM.png)


### Versions

- Ruby 2.5.3

- Rails 5.2.5

### Local Setup

1. Fork and Clone this repo
2. Install gem packages above
3. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`

## Running the tests

Run all tests in application with `bundle exec rspec`. When test is complete, run `open coverage` to see where tests are being run and where they are not.

## Deployment

- Add Heroku app link
- If you'd like to run this app locally, run `rails s` and navigate to `http://localhost:3040/` in your browser.

In order to use this application, you need to register for a [MovieDB API Key](https://www.themoviedb.org/settings/api). Once you have the key, use command `bundle exec install figaro`. This creates the file `config/application.yml`. In `application.yml`, add `MOVIE_TOKEN: <your MovieDB api key>`.

## Built Using

  - Ruby on Rails
  - HTML/CSS

## Built By

- [Jahara Clark](https://github.com/jaharaclark)
- [Klaudia Stewart](https://github.com/klaudiastewart)


## Acknowledgments

We'd like to thank Turing School of Software and Engineering for helping us come up with the idea for this application. Thank you to Theresa Marquis for helping us when we'd get into a sticky situation. Thank you to the MovieDB for allowing us to use your API. Lastly, thank you for reading through this project!
