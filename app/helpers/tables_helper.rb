module TablesHelper
  def green_if(condition)
    if condition
      { class: 'success' }
    else
      { class: 'error' }
    end
  end
end
