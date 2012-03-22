class User < Sequel::Model
  one_to_many :repositories

  attr_accessor :password, :password_confirmation

  def validate
    # todo validate name / email uniqueness, password len ...
    if password or password_confirmation
      errors.add "password not match" if password != password_confirmation
    end
  end

  def before_create
    self.encrypted_password = BCrypt::Password.create(password).to_s
  end

  def self.auth name_or_email, password
    if name_or_email =~ /.@./
      user = where(email: name_or_email)
    else
      user = where(name: name_or_email)
    end
    if user
      p = BCrypt::Password.new user.encrypted_password
      if p == password
        user
      end
    end
  end

end
