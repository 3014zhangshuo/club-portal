module ApplicationHelper
  def print_messages model
    flash_messages = []
    unless not defined?model or model.errors.empty?
      messages = model.errors.full_messages.map { |msg| content_tag(:span, msg) }.join('</br>').html_safe
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + messages, :class => "alert fade in alert-error")
      flash_messages << text
    end
    unless flash.empty?
      flash.each do |type, message|
        type = :success if type == :notice
        text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
        flash_messages << text
      end
    end
    flash_messages.join("\n").html_safe unless flash_messages.empty?
  end

  def print_error_messages resource
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count)

    html = <<-HTML
    <div class="alert alert-error">
      <a class="close" data-dismiss="alert">x</a>
      <strong>#{sentence}</strong>
      <ul>
        #{messages}
      </ul>
    </div>
    HTML

    html.html_safe
  end

end
