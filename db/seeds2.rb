User.delete_all
Company.delete_all
Carpool.delete_all
# ip = Faker::Internet.ip_v4_address

streets = ["Rue Viollier 4","Rue Viollier 40", "Route de Florissant 81","Route de Florissant 11", "Route de Chancy 12","Route de Chancy 50", "Route d'Aïre 157", "Route d'Aïre 57", "Avenue Trembley 27", "Avenue Trembley 47", "Route de Satigny 11", "Route de Satigny 110", "Route de la Capite 276","Route de la Capite 76", "Route d'Annecy 140", "Route d'Annecy 20"]

loz_streets=["Rue Caroline 12","Rue Pépinet 5","Rue de Maupas 14","Avenue Sainte-Luce 4", "26B Avenue Parc de la rouvraie"]

c = Company.create!(name: 'UEFA', email: 'uefa@uefa.com', password: 'upw', password_confirmation: 'upw', street: 'Route de Genève 46', city: 'Nyon', state: 'Vaud', country: 'Switzerland' )

u = c.users.create!(name: 'nick', email: 'n@n.com', password: 'pw', password_confirmation: 'pw', building: "HH")

5.times do
  c=Company.create!(name: Faker::App.name, email: Faker::Internet.email, password: 'upw', password_confirmation: 'upw', street: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, country: Faker::Address.country)
end

5.times do
  c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4) )
  c.rides.where(user_id: u.id).first.update(driver?: true, street: loz_streets.sample, city: "Lausanne", state: "Vaud", country: "Switzerland")

end

10.times do
  u = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'pw', password_confirmation: 'pw', building: "HH")
  5.times do
    c = u.carpools.create!(date: Faker::Time.forward(44), name: Faker::App.name, capacity: 3, range: rand(1..4))
    c.rides.where(user_id: u.id).first.update(driver?: true, street: streets.sample, city: "Geneva", state: "Geneva", country: "Switzerland")
  end
end

25.times do
    c = Carpool.all.sample
    u = User.all.sample
    
    while c.users.exists?(u)
      u=User.all.sample
    end
    
    c.passengers << u
    
    adrs = Ride.all_addresses.where.not(user_id: u.id, carpool_id: c.id).select(:street, :city, :state, :country)

    
    if !c.rides.where(street: nil).empty? and !adrs.empty?
      c.rides.where(street: nil).each{ |ride| ride.update(adrs.sample.attributes.except("id")) }
    end
    
end


