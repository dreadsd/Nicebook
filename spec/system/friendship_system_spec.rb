require 'rails_helper'

RSpec.describe "Friendship System", type: :system do
  let!(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
  let!(:jane) { User.create(name: "Jane Doe", email: "jane@doe.com", password: "12345678") }

  before do
    driven_by(:rack_test)

    sign_in john
    visit "/"
  end

  describe "received friend requests" do
    before do
      jane.send_request_to(john)
      visit "/"
      expect(find("#dropdown-requests")).to have_content(jane.name)
    end

    context "accept friend request" do
      before do
        find(".accept-friend-request").click
      end

      it "removes request from list" do
        expect(find("#dropdown-requests")).not_to have_content(jane.name)
      end

      it "adds friend to list" do
        expect(find("#list-friends")).to have_content(jane.name)
      end
    end

    context "reject friend request" do
      before do
        find(".reject-friend-request").click
      end

      it "removes request from list" do
        expect(find("#dropdown-requests")).not_to have_content(jane.name)
      end

      it "doesn't add friend to list" do
        expect(find("#list-friends")).not_to have_content(jane.name)
      end
    end
  end

  describe "add and delete friends" do
    context "send a friend request" do
      before do
        expect(find("#list-people")).to have_content(jane.name)
        find(".send-friend-request").click
      end

      it "removes send-friend-request link" do
        expect(find("#list-people")).not_to have_selector(".send-friend-request")
      end

      it "adds cancel-friend-request link" do
        expect(find("#list-people")).to have_selector(".cancel-friend-request")
      end

      it "stays in people list" do
        expect(find("#list-people")).to have_content(jane.name)
      end

      it "doesn't add to friends list" do
        expect(find("#list-friends")).not_to have_content(jane.name)
      end

      describe "cancel friend request" do
        before do
          find(".cancel-friend-request").click
        end

        it "removes cancel-friend-request link" do
          expect(find("#list-people")).not_to have_selector(".cancel-friend-request")
        end

        it "adds send-friend-request link" do
          expect(find("#list-people")).to have_selector(".send-friend-request")
        end
      end
    end

    context "delete a friend" do
      before do
        john.send_request_to(jane)
        jane.friend_requests.first.accept_request
        visit "/"

        expect(find("#list-friends")).to have_content(jane.name)
        find(".delete-friend").click
      end

      it "removes from friends list" do
        expect(find("#list-friends")).not_to have_content(jane.name)
      end

      it "adds to people list" do
        expect(find("#list-people")).to have_content(jane.name)
      end
    end
  end
end
