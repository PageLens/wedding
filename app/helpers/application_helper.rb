module ApplicationHelper
  def pagination_for(collection)
    content_tag(:div, will_paginate(collection, inner_window: 1, renderer: BootstrapPagination::Rails), class: 'text-center')
  end
end
