get '/repositories' do
  @repositories = Repository.paginate(:page => params[:page])
  respond_to do |f|
    f.html { slim :'repositories/index' }
    f.json { @repositories.to_json }
  end
end

get '/repositories/new' do
  @repository = Repository.new
  slim :'repositories/new'
end

get '/repositories/:name' do |name|
  redirect "/repos/#{name}/tree/master"
end

get '/repositories/:name/tree/:branch' do |name, branch|
  @repo = Repository.repo
  @commit = @repo.commits(branch).first
  @tree = @commit.tree
  @path = ""
  respond_to do |f|
    f.html { slim :'repositories/tree' }
    f.json { @repositories.to_json }
  end
end

get '/repositories/:name/tree/:branch/*' do |name, branch, path|
  @branch = branch
  @repo = Repository.repo
  @commit = @repo.commits(branch).first
  @object = @commit.tree / path
  @path = path + "/"
  @tree = @object
  slim :'repositories/tree'
end

post '/repositories' do
  Repository.create(params)
  redirect '/repositories'
end
