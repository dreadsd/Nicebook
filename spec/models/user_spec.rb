require "rails_helper"
require "support/validate_record_helper.rb"

RSpec.configure { |c| c.include RecordValidations }

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid when name is not given" do
      check_validation_of(User.new(email: "dummy@test.com", password: "12345678"), :invalid?)
    end

    it "is invalid when name is less than 4 characters" do
      check_validation_of(User.new(name: "dum", email: "dummy@test.com", password: "12345678"), :invalid?)
    end

    it "is valid when name is more than 4 characters" do
      check_validation_of(User.new(name: "Dummy Test", email: "dummy@test.com", password: "12345678"), :valid?)
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

      describe "delete friend" do
        before do
          expect { jane.delete_friend(john) }.not_to raise_error
        end

        it "deletes friend for one side" do
          expect(jane.friends).to be_empty
        end

        it "deletes friend for the other side" do
          expect(john.friends).to be_empty
        end
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
