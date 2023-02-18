Sniffspot Clone - Rails Backend
This is the backend component of a limited feature version of Sniffspot, a platform for booking private spaces for dogs. This project is created as part of a technical interview process and is intended to demonstrate my understanding of building a RESTful API using Ruby on Rails.

Requirements
To run this project, you will need to have the following installed on your system:

Ruby (version 3.0.0)
Ruby on Rails (version 7.0.4)
PostgreSQL (version 12.8 or higher)

Getting Started
To get started with this project, follow the steps below:

Clone the project repository to your local machine.
`git clone https://github.com/umersajad/SniffSpot-backend.git`
Navigate to the project directory using the command line.
Run `bundle install` to install the required gems.
Create a new PostgreSQL database by running `rails db:create`
Run the database migrations by running rails `db:migrate`
Populate Database with csv data
`rails db:seed`
Run `rails server` to start the development server.
Once the server is running, you can test the API using a tool such as Postman

Testing
This project includes unit tests for the API. To run the tests, simply execute the following command:
`bundle exec rspec`

Contributing
This project is part of a technical interview process and is not open for contributions at this time.
