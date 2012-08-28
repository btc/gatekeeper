module ApplicationHelper
  def active_if(path)
    if current_page?(path)
      { class: 'active' }
    else
      {}
    end
  end
end
