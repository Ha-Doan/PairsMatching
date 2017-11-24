User.destroy_all

user1 = User.create!({email: "jason@mail.com", password: "123456", role: "student"})
user2 = User.create!({email: "ha@mail.com", password: "123456", role: "student"})
user3 = User.create!({email: "nora@mail.com", password: "123456", role: "student"})
user4 = User.create!({email: "johan@mail.com", password: "123456", role: "student"})
user5 = User.create!({email: "david@mail.com", password: "123456", role: "student"})
user6 = User.create!({email: "matthijs@mail.com", password: "123456", role: "student"})
user7 = User.create!({email: "mary@mail.com", password: "123456", role: "admin"})
user8 = User.create!({email: "peter@mail.com", password: "123456", role: "admin"})
