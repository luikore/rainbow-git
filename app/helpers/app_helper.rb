helpers do
  include FormHelpers
  include I18nHelpers

  def sl(template, options={})
    slim(template, options.merge(:layout => :'layouts/application'))
  end

  def current_user
    nil
  end

  def alert
    nil
  end

  def notice
    nil
  end
end
