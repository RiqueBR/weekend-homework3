require_relative('../db/sql_runner')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

  def save
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def update
    sql = "UPDATE customers SET (name, funds)
    = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films
    sql = "SELECT films.* FROM films INNER JOIN screenings ON
    screenings.film_id = films.id INNER JOIN tickets ON
    tickets.screening_id = screenings.id WHERE customer_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return result = customers.map { |customer_hash| Customer.new(customer_hash)}
  end

  def self.all
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer_hash| Customer.new(customer_hash) }
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end


end
