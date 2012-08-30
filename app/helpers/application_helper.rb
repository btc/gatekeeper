module ApplicationHelper
  def active_if(path, other_condition = true)
    if current_page?(path) && other_condition
      { class: 'active' }
    else
      {}
    end
  end
end
