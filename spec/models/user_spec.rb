require 'rails_helper'

RSpec.describe User, type: :model do
  context "sends friend request" do
    let(:john) { User.create(email: "john@doe.com", password: "12345678") }
    let(:jane) { User.create(email: "jane@doe.com", password: "12345678") }

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

    describe "the receiver accepts the request" do
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
  end
end
