require_relative('../db/sql_runner')
require_relative('student')

class House

  attr_reader :name, :id

  def initialize( options )
    @id = options['id'].to_i()
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO houses
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@name]
    house_data = SqlRunner.run(sql, values)
    @id = house_data.first()['id'].to_i()
  end

  def update()
    sql = "UPDATE houses
    SET
    (
      name
      ) =
      (
        $1
        ) WHERE id = $2"
        values = [@name, @id]
        SqlRunner.run(sql, values)
  end

  def student()
    sql = "SELECT * FROM students WHERE id = $1"
    values = [@student_id]
    results = SqlRunner.run(sql, values)
    student_hash = results[0]
    student = Student.new(student_hash)
    return student
  end

  def self.all()
    sql= "SELECT * FROM houses"
    houses = SqlRunner.run(sql)
    result = houses.map{ |house| House.new( house )}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house = SqlRunner.run(sql, values)
    result = House.new( house.first)
    return result
  end

  def self.delete_all
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

end
