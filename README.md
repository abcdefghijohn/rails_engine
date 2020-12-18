## Rails Engine

Rails Engine is an ecommerce application that tracks customers, merchants, and sales through invoices, invoice items, and transactions. The front and back ends of this application are separate and communicate via APIs, thus the backend must expose the data for the frontend through APIs.


## Learning Goals

**Expose an API**

-Utilized seed data for multiple API endpoints

**Serializers**

-Utilized serializers to select data needed
-Utilized fast_jsonapi to render and format json 

**Test API Exposure**

-To test connection between front and back end used rails_driver 

-Utilized spec harness in rails_driver

-Created requests to test api endpoints

**Compose advanced ActiveRecord Queries**

-Created AR queries in models to expose api endpoints 


## Versions

Ruby 2.5.3

Rails 5.2.4.3


## Local Setup

1. Create a local directory ie: `mkdir rails_engine`
2. `cd` into the newly created directory and clone the following repos.
Backend portion
`git clone https://github.com/abcdefghijohn/rails_engine`
Frontend portion 
`https://github.com/abcdefghijohn/rails_driver`
**Ensure these directories are both within the directory you made in step 1**
3. `cd` into the rails_engine directory and run your `bundle install` 
4. Setup the database: `rails db:create`
5. Create the necessary tables and run `rails db:migrate`
6. Place these two files [items.csv](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/items.csv) and 
[pgdump](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump) in your `db/data` folder in your project. 
7. Run `rails db:seed`

## Schema

![Screen Shot 2020-12-18 at 4 28 43 AM](https://user-images.githubusercontent.com/65986168/102609966-9ff31e00-40e9-11eb-949d-37f82a53d19d.png)

## Testing

- After you `cd` into the `rails_engine` directory use `cmd + tab` to open a new tab in your terminal
- In your original tab run `rails s`
- From the second tab `cd` into the `rails_driver` directory and run your `bundle exec rspec` to compare your application to the spec_harness. 


