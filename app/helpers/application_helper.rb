module ApplicationHelper
  def page_classes
    "#{controller.controller_name}_controller #{controller.action_name}"
  end

  def rounded number
    number.to_f.round(2).to_currency
  end
end
