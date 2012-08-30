module ApplicationHelper
  def active_if(path, other_condition = true)
    if other_condition && current_page?(path)
      { class: 'active' }
    else
      {}
    end
  end
end
