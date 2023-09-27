# Sweater Weather 

*An application developed with Ruby on Rails*

 This service aggregates data from external sources, requires user authentication, offers CRUD operations, and undergoes extensive testing, including mocking external APIs with vcr. It essentially lets users to see the current weather as well as the forecasted weather at the destination. 

## Authors
- Gabe Torres [GitHub](https://github.com/Gabe-Torres) | [LinkedIn](https://www.linkedin.com/in/gabe-torres-74a515269/)

## Summary 
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [Test Suite](#test-suite)
- [Developed With](#developed-with)
- [API JSON Contract](#api-json-contract)

## Getting Started

**Schema**

```ruby
ActiveRecord::Schema[7.0].define(version: 2023_09_17_200123) do
  enable_extension "plpgsql"

   create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
  end
end
```

 **Gems**
 ```ruby
    gem "faraday"
    gem 'jsonapi-serializer'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "pry"
  gem "rspec-rails"
  gem "capybara"
  gem "shoulda-matchers"
  gem "vcr"
  gem "webmock"
  gem "simplecov"
end
 ```
 
 **Installing**
 - Fork and clone this repo
  - Run `bundle install`
  - Run `rails db:{create,migrate,seed}`
  - Run `rails s` to start the server
  - Open your browser and navigate to `localhost:3000`

## API JSON Contract
*Description of API endpoints for front end application*

> `GET /api/v0/forecast`

*Success Response (200 OK):*

<!-- - Location:  -->
```ruby
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
``` 
---

> `POst /api/v0/registration`

*Success Response (200 OK):*

```ruby 
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
---

> `POst /api/v0/road_trip`

*Success Response (200 OK):*


```ruby
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

```ruby
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```
# Routes

| Action | Route |
| ----------- | ----------- |
| get | '/api/v0/forecast' |
| post | '/api/v0/registration' |
| post | '/api/v0/cards/road_trip' |

# Test Suite
 - run `bundle exec rspec` to run the test suite

**HappyPath**

```ruby
  context 'POST /sessions' do
    scenario 'returns user api key', :vcr do 
      valid_attributes = {
        email: 'email@email.com',
        password: 'password',
        password_confirmation: 'password'
      }

      user = User.create(valid_attributes)
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/sessions', headers: headers, params: valid_attributes.to_json

      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end
```

```ruby
context 'POST /registration' do
    scenario 'creates a new user' do
      valid_user = ({ 
        email: 'myemail@email.com',
        password: 'password',
        password_confirmation: 'password'
      })
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/registration', headers: headers, params: valid_user.to_json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to match(a_string_including('application/json'))
      expect(response).to be_successful

      response_body = JSON.parse(response.body)
      expect(response_body['data']['type']).to eq('users')
      expect(response_body['data']['attributes']['email']).to eq(valid_user[:email])
      expect(response_body['data']['attributes']['api_key']).to be_a(String)
      expect(response_body['data']['attributes']['api_key'].length).to eq(24)
      expect(response_body['data']['attributes']['password_digest']).to be_nil
    end
  end
```
---

**SadPath**

```ruby 
context 'POST /sessions sad path' do
    scenario 'returns an error passwords dont match' do
      invalid_attributes = {
        email: 'email@gmail.com',
        password: 'password',
        password_confirmation: 'notpassword'
      }
        user = User.create(invalid_attributes)
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v0/sessions', headers: headers, params: invalid_attributes.to_json

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        expect(error_response[:error]).to eq("Invalid credentials")
    end
  end
```

```ruby
 context 'POST /registration sad path' do
    scenario 'returns an error passwords dont match' do
      invalid_user = ({
        email: "email@email.com",
        password: "password",
        password_confirmation: "notpassword"
      })
      header = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/registration', headers: header, params: invalid_user.to_json

      error_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(response.status).to eq(400)
      expect(error_response[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
```
---
# Developed With
---
<img src="https://user-images.githubusercontent.com/127896538/267407283-0389dace-15c6-493c-a3b7-3a833f0a20f2.png" width="50" alt="Rails Logo"><img src="https://raw.githubusercontent.com/devicons/devicon/55609aa5bd817ff167afce0d965585c92040787a/icons/github/github-original.svg" width="50" alt="github Logo"><img src="https://user-images.githubusercontent.com/127896538/267406979-5e0db686-91a1-42ee-9bda-675a5c5c2266.png" width="50" alt="Ruby Logo">