User.delete_all
Company.delete_all
Carpool.delete_all
# ip = Faker::Internet.ip_v4_address

streets = ["Rue Viollier 4","Rue Viollier 40", "Route de Florissant 81","Route de Florissant 11", "Route de Chancy 12","Route de Chancy 50", "Route d'Aïre 157", "Route d'Aïre 57", "Avenue Trembley 27", "Avenue Trembley 47", "Route de Satigny 11", "Route de Satigny 110", "Route de la Capite 276","Route de la Capite 76", "Route d'Annecy 140", "Route d'Annecy 20"]

loz_streets=["Rue Caroline 12","Rue Pépinet 5","Rue de Maupas 14","Avenue Sainte-Luce 4", "26B Avenue Parc de la rouvraie"]

c = Company.create!(name: 'UEFA', email: 'uefa@uefa.com', password: 'upw', password_confirmation: 'upw', street: 'Route de Genève 46', city: 'Nyon', state: 'Vaud', country: 'Switzerland' )

u = c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', building: "HH")

# u.addresses.create!(street: "Chemin du Pommier 14", city: "Geneva", state: "Geneva", country: "Switzerland")

5.times do
  c=Company.create!(name: Faker::App.name, email: Faker::Internet.email, password: 'upw', password_confirmation: 'upw', street: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, country: Faker::Address.country)
end

5.times do
  c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4) )
  # c.addresses << u.addresses.sample
  c.rides.find_by(user_id: u.id).update(driver?: true, street: loz_streets.sample, city: "Lausanne", state: "Vaud", country: "Switzerland")
  c.save
end

5.times do
  u = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'pw', password_confirmation: 'pw', building: "HH")
  10.times do
    c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4))
    c.rides.find_by(user_id: u.id).update(driver?: true, street: streets.sample, city: "Geneva", state: "Geneva", country: "Switzerland")
    c.save
  end
end

25.times do
    c = Carpool.find(rand(1..54))
    u = User.find(rand(1..5))
    c.users << u
    
    a = Ride.all_addreses
    
    u2 = User.where("id != ?", u.id).includes(:rides).where(passengers).sample
    
    r = c.rides.find_by(user_id: u.id)

    if r.street.nil?
      r.reverse_address_str_update(u2.addresses.select{ |addr| addr.street != nil && addr.user})
    end
    # r.update(u.addresses.sample)
    # c.addresses << u.addresses.sample
end


