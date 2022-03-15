require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) {User.create(first_name: "Melissa", last_name: "Holmes", email: "ummm@example.com", password: "example1", password_confirmation: "example1")}

describe 'Validations' do 
  it 'is valid with all valid inputs' do
    expect(user).to be_valid
end
 
  it 'is not valid without a password' do
    user.password = nil
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Password can't be blank")
  end 

  it "is not valid if password confirmation doesn't match password" do
    user.password = "hello111"
    user.password_confirmation = "different"
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "is not valid if email is not unique" do
    user_one = User.create(first_name: "Rufus", last_name: "Meows", email: "mango@example.com", password: "oink1234", password_confirmation: "oink1234")

    user_two = User.create(first_name: "Rufus", last_name: "Meows", email: "MANGO@example.com", password: "oink1234", password_confirmation: "oink1234")

  expect(user_two).to_not be_valid
  expect(user_two.errors.full_messages).to include("Email has already been taken")
  end

  it "is not valid without an email" do
    user.email = nil
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Email can't be blank")
  end

  it "is not valid without a first name" do
    user.first_name = nil
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("First name can't be blank")
  end
  
  it "is not valid without a last name" do
    user.last_name = nil
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Last name can't be blank")
  end
  
  it "must have at least the minimum password length" do
   user_three = User.new(first_name: "Holly", last_name: "Smith", email: "orange@example.com", password: "k", password_confirmation: "k")
   expect(user_three).to_not be_valid
  expect(user_three.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
  end
end


  describe '.authenticate_with_credentials' do 
    
    it "returns nil if a user isn't authenticated" do
      user_four = User.create(first_name: "Jim", last_name: "Halpert", email: "jim_pam@example.com", password: "scranton123", password_confirmation: "scranton123")

      expect(User.authenticate_with_credentials("jim_pam@example.com", "This-is-wrong")).to be_nil
  end

it "returns the user if they are authenticated" do
      user_four = User.create(first_name: "Jim", last_name: "Halpert", email: "jim_pam@example.com", password: "scranton123", password_confirmation: "scranton123")
      
      expect(User.authenticate_with_credentials("jim_pam@example.com", "scranton123")).to be_instance_of(User)
end

it "allows a user to login with whitespace in their email" do
  user_four = User.create(first_name: "Jim", last_name: "Halpert", email: "jim_pam@example.com", password: "scranton123", password_confirmation: "scranton123")

  expect(User.authenticate_with_credentials("      jim_pam@example.com", "scranton123")).to be_instance_of(User)
end

it "allows a user to login with correct email regardless of case" do
  user_four = User.create(first_name: "Jim", last_name: "Halpert", email: "jim_pam@example.com", password: "scranton123", password_confirmation: "scranton123")

  expect(User.authenticate_with_credentials("Jim_Pam@example.com", "scranton123")).to be_instance_of(User)
end



end
end