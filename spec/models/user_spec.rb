require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validates instance" do
    describe "name" do
      it "doesn't save user if no name" do
        expect { User.create!(email: "dummy@test.com", password: "12345678") }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't save user if name is less than 4 characters" do
        expect { User.create!(name: "dum", email: "dummy@test.com", password: "12345678") }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "saves the user if name more than 4 characters" do
        expect { User.create!(name: "Dummy Test", email: "dummy@test.com", password: "12345678") }.not_to raise_error
      end
    end
  end

  describe "sends friend request" do
    let(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
    let(:jane) { User.create(name: "Jane Doe", email: "jane@doe.com", password: "12345678") }

    before do
      expect(jane.friend_requests).to be_empty
      expect { john.send_request_to(jane) }.not_to raise_error
    end

    it "receives one object" do
      expect(jane.friend_requests.size).to eq 1
    end

    it "receives a friend request" do
      expect(jane.friend_requests.first).to be_an_instance_of(Friendship)
    end

    context "the receiver accepts the request" do
      before do
        expect { jane.friend_requests.first.accept_request }.not_to raise_error
      end

      it "sets the friend for the receiver" do
        expect(jane.friends.first).to eq(john)
      end

      it "sets the friend for the sender" do
        expect(john.friends.first).to eq(jane)
      end
    end

    context "the receiver rejects the request" do
      before do
        expect { jane.friend_requests.first.destroy }.not_to raise_error
        jane.friend_requests.reload
      end

      it "kills the friend request" do
        expect(jane.friend_requests).to be_empty
      end
    end
  end
end
