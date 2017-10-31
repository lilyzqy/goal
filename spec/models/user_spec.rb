require 'rails_helper'
require 'byebug'
RSpec.describe User, type: :model do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6)}

    describe 'password encryption'
      subject(:jackie) { User.create!(username: 'jackie', password: 'abcdef') }
      it 'does not save passwords to the database' do
        password = jackie.password
        user = User.find_by(username: 'jackie')
        expect(user.password).not_to be(password)
      end

      it 'encrypts the password using BCrypt' do
        expect(BCrypt::Password).to receive(:create)
        User.new(username: 'guy', password: 'abcdef')
      end

    describe 'session token' do
      it 'sets a session token if one is not given' do
        lily = User.new(username: 'Lily', password: 'password')
        expect(lily.session_token).not_to be_nil
      end
    end



    describe "self.find_by_credentials" do
      subject(:bruce) { User.create!(username: 'bruce', password: 'abcdef') }

      it "find user by username" do

        user = User.find_by(username: 'bruce')
        expect(user.username).to eq(bruce.username)
      end

      context "invalid username"
        it "will return nil " do
          user = User.find_by(username: "name")
          expect(user).to be_nil
        end

      context "Valid username"
        it "check if the password is the correct password" do

        end

        it "return the user" do

        end
    end
end
