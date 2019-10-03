require_relative('../db/sql_runner')

class Student

  attr_reader :first_name, :last_name, :age, :house, :id

  def initialize( options )
    @id = options['id'].to_i()
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age']
    @house = options['house']
  end

  def pretty_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO students
    (
      first_name,
      last_name,
      age,
      house
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *"
    values = [@first_name, @last_name, @age, @house]
    student_data = SqlRunner.run(sql, values)
    @id = student_data.first()['id'].to_i()
  end

  def update()
    sql = "UPDATE students
    SET
    (
      first_name,
      last_name,
      age,
      house
      ) =
      (
        $1, $2, $3, $4
        ) WHERE id = $5"
        values = [@first_name, @last_name, @age, @house, @id]
        SqlRunner.run(sql, values)
  end

  def self.all()
    sql= "SELECT * FROM students"
    students = SqlRunner.run(sql)
    result = students.map{ |student| Student.new( student )}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    student = SqlRunner.run(sql, values)
    result = Student.new( student.first)
    return result
  end

end
