require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do

    it "should pass if password and password_confirm match" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user).to be_valid
    end

    it "invalid if password and password_confirm doesn't match" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "1234567"
      )
      expect(user).to be_invalid
    end

    it "email must be unique" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )

      user.save!

      user2 = User.new(
        first_name: "Red",
        last_name: "Bear",
        email: "CAT@MEOW.COM",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user2).to be_invalid
    end

    it "password length must be 5 or more characters" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(user).to be_invalid
    end

    it "password cannot be empty" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "",
        password_confirmation: ""
      )
      expect(user).to be_invalid
    end

  end

  describe ".authenticate" do

    it "should login with valid email and password" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )
      user.save!
      authorized_user = User.authenticate_with_credentials(user.email, user.password)
      expect(authorized_user).to eq(user)
    end

    it "cannot login with invalid email and password" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )
      user.save!
      authorized_user = User.authenticate_with_credentials("meow@meow.com", user.password)
      expect(authorized_user).to be_nil
    end

    it "space should be ignore when typing in email for login" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )
      user.save!
      authorized_user = User.authenticate_with_credentials("     cat@meow.com", user.password)
      expect(authorized_user).to eq(user)
    end

    it "email is not case sensitive" do
      user = User.new(
        first_name: "Cat",
        last_name: "Meow",
        email: "cat@meow.com",
        password: "12345",
        password_confirmation: "12345"
      )
      user.save!
      authorized_user = User.authenticate_with_credentials("      cAt@mEow.coM", user.password)
      expect(authorized_user).to eq(user)
    end

  end

end
