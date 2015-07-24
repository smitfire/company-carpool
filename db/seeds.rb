# ip = Faker::Internet.ip_v4_address

streets = ["Rue Viollier 4","Rue Viollier 40", "Route de Florissant 81","Route de Florissant 11", "Route de Chancy 12","Route de Chancy 50", "Route d'Aïre 157", "Route d'Aïre 57", "Avenue Trembley 27", "Avenue Trembley 47", "Route de Satigny 11", "Route de Satigny 110", "Route de la Capite 276","Route de la Capite 76", "Route d'Annecy 140", "Route d'Annecy 20"]

c = Company.create!(name: 'UEFA', email: 'uefa@uefa.com', password: 'upw', password_confirmation: 'upw', street: 'Route de Genève 46', city: 'Nyon', state: 'Vaud', country: 'Switzerland')

u = c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', street: "Chemin du Pommier 14", city: "Geneva", state: "Geneva", country: "Switzerland", building: "HH")

# c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude )

5.times do
  Company.create!(name: Faker::App.name, email: Faker::Internet.email, password: 'upw', password_confirmation: 'upw', street: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, country: Faker::Address.country)
end

5.times do
  c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4) )
  c.rides.find_by(user_id: u.id).update(driver?: true)
  c.save
end

5.times do
  u = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'pw', password_confirmation: 'pw', street: streets.sample, city: "Geneva", state: "Geneva", country: "Switzerland", building: "HH")
  5.times do
    c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4) )
    c.rides.find_by(user_id: u.id).update(driver?: true)
    c.save
  end

end

15.times do
    c = Carpool.find(rand(1..24))
    c.users << User.find(rand(1..4))
end


