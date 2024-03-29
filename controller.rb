require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/student')
also_reload('./models/*')

get "/students" do
  @students = Student.all()
  erb( :index )
end

get "/students/new" do
  erb(:new)
end

post "/students" do
  @student = Student.new(params)
  @student.save()
  erb(:create)
end

get "/students/:id" do
  @student = Student.find(params["id"])
  erb(:show)
end
