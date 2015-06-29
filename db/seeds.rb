# ip = Faker::Internet.ip_v4_address
c = Company.create!(name: Faker::Company.name) 
# c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude )
c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', street: "Chemin du Pommier 14", city: "Geneva", state: "Geneva", country: "Switzerland")

streets = ["Rue Viollier 4", "Route de Florissant 81", "Route de Chancy 12", "Route d'Aïre 157", "Avenue Trembley 27", "Route de Satigny 11", "Route de la Capite 276", "Route d'Annecy 140"]

10.times do
  # c.users.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'pw', password_confirmation: 'pw', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude )
  u = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'pw', password_confirmation: 'pw', street: streets.sample, city: "Geneva", state: "Geneva", country: "Switzerland")
  10.times do
    c = u.driver_carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4))
  end

end

30.times do
    c = Carpool.find(rand(1..99))
    c.passengers << User.find(rand(1..9))
end


