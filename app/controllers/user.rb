get '/user/new' do
  @user = User.new
  slim :'user/new'
end

post '/user' do
  'todo'
end
