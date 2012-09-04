module ApplicationHelper
  def active_if_controller(controller, other_condition = true)
    if other_condition && params[:controller] == controller.to_s
      { class: 'active' }
    else
      {}
    end
  end

  def active_if(path, other_condition = true)
    if other_condition && current_page?(path)
      { class: 'active' }
    else
      {}
    end
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
