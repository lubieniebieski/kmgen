module ApplicationHelper
  def page_classes
    "#{controller.controller_name}_controller #{controller.action_name}"
  end
end
