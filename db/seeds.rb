User.create(email: "john@doe.com", password: "johndoe01", password_confirmation: "johndoe01")
User.create(email: "jane@doe.com", password: "janedoe01", password_confirmation: "janedoe01")
User.create(email: "bob@rock.com", password: "bobrock01", password_confirmation: "bobrock01")
User.create(email: "tito@poo.com", password: "titopoo01", password_confirmation: "titopoo01")
User.create(email: "mama@mas.com", password: "mamamas01", password_confirmation: "mamamas01")

User.first.posts.create(body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
User.first.posts.create(body: "Contrary to popular belief, Lorem Ipsum is not simply random text.")
User.second.posts.create(body: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.")
