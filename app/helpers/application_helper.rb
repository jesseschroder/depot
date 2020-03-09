module ApplicationHelper

  def render_if(condition, record)
    render record if condition
  end

  def checkout_page
    controller_name == 'orders' && action_name == 'new'
  end
end
