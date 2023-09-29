# Cash Register Application
This project aims to create an cash register platform with a focus on managing shopping carts, products, and promotions. It's designed to have operations such as adding products to a cart, applying promotions, and calculating cart totals. This project is seperated into 2 parts, a backend and a frontend.

## Requirements

Before running the application, ensure you have the following software installed on your machine:

- **Ruby:** Version 2.6 or higher
- **Command-line Interface:** To execute commands in the terminal.

## Installation
1. Clone the repository to your local machine.
2. Navigate to 'cash-register-api'
3. Run the following command to install all the dependicies on the backend.
```bash
  bundle install
```
4. Run `rails db:seed` in order to create basic data in the database.

## Usage

1. In your terminal, run `rails server` this will start the server on the 3000 port. This step is very important. You want to make sure you start your backend first to ensure it runs on the correct port.
2. Everything is set up for you to start using your cash-register-api!!

## Project Structure
### RoR Backend API
- Models - This is where the data and business logic of the application is defined. We have `Product`, `Promotion`, `Cart` and `CartItem` models. This models define the attributes and the relationships between them. And also include validations and methods to perform operations.

- Controllers - This is where HTTP requests are processed and interact with the models. `Product` and `Promotion` controllers are used to render all the `Products` and `Promotions` as JSON. `Cart` controller is responsible for the checkout method, that validates the `Cart` received from the client side.

- Rspec - This is where all the tests for the controllers and models are located. To run the tests you can use the `bundle exec rspec` in the terminal.
