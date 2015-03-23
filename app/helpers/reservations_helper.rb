module ReservationsHelper
  def error_text(form, attribute)
    if form.object.errors[attribute].any?
      content_tag(:span, form.object.errors[attribute].first, class: 'help-block')
    end
  end
end
