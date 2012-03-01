module DeviseHelper
  def my_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("devise.failure.not_saved",
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