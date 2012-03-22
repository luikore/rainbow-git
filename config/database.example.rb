DB = Sequel.connect(:adapter=>"postgres",
                    :host=>"localhost",
                    :database=>"dbname_#{ENV["RACK_ENV"]}",
                    :user=>"",
                    :password=>"")
