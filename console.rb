require_relative('./models/films')
require_relative('./models/customers')
require_relative('./models/tickets')
require_relative('./models/screenings')

require('pry')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()


film1 = Film.new ({ "title" => "Rocky", "price" => 10})
film1.save()
film1.title = "Rocky Balboa"
film1.update()

film2 = Film.new ({ "title" => "The Life of Brian", "price" => 10})
film2.save()

customer1 = Customer.new ({ "name" => "Henrique", "funds" => 50})
customer1.save()
customer1.funds = 100
customer1.update()

customer2 = Customer.new ({ "name" => "Fiona", "funds" => 30})
customer2.save()

screening1 = Screening.new ({ "start_time" => "1430", "empty_seats" => 20, "film_id" => film1.id})
screening1.save()
screening1.empty_seats = 15
screening1.update

screening2 = Screening.new ({ "start_time" => "1800", "empty_seats" => 10, "film_id" => film2.id})
screening2.save()

ticket1 = Ticket.new ({"customer_id" => customer1.id, "screening_id" => screening1.id})
ticket1.save()
ticket1.customer_id = customer2.id
ticket1.update()

ticket2 = Ticket.new ({"customer_id" => customer1.id, "screening_id" => screening1.id})
ticket2.save()

ticket3 = Ticket.new ({"customer_id" => customer1.id, "screening_id" => screening2.id})
ticket3.save()

binding.pry
nil
