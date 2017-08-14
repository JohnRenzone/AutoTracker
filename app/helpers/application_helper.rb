module ApplicationHelper
  include CommonHelper

  # Render a partial only one time.
  #
  # Useful for rendering partials that require JavaScript like Google Maps
  # where other views may have also included the partial.
  def render_once(view, *args, &block)
    @_render_once ||= {}
    if @_render_once[view]
      nil
    else
      @_render_once[view] = true
      render(view, *args, &block)
    end
  end

  def generate_pdf(report)
    pdf = render_to_string pdf: "test", template: "vehicle_report_cards/show.html.haml"
    send_data(pdf,
              :filename => "report-#{params[:id]}.pdf",
              :disposition => 'attachment')
  end

  def toggle_order column
    current_sort = params[:order].try(:[], column)
    sort = current_sort && current_sort == 'asc' ? 'desc' : 'asc'
    {column => sort}
  end

  def pdf_legend(form_object, column, type)
    check_box_classes_hash = {'g' => 'css-checkboxgreen', 'y' => 'css-checkbox', 'r' => 'css-checkboxred' }
    label_classes_hash = {'g' => 'css-labelgreen', 'y' => 'css-label', 'r' => 'css-labelred' }

    html_element = form_object.check_box :light_legend, {class: check_box_classes_hash[type], checked: form_object.object.send(column) == type}, type, ''
    html_element + content_tag(:label, nil, class: label_classes_hash[type])
  end

  def pdf_checkbox(form_object, column)
    if form_object.object.send(column)
      html_element = form_object.check_box column, {class: 'css-checkboxSimple', checked: form_object.object.send(column)}
      html_element + content_tag(:label, nil, class: 'css-labelSimple')
    else
      html_element = form_object.check_box column, {class: 'css-checkboxSimple'}
      html_element + content_tag(:label, nil, class: 'css-labelSimple')
    end
  end

  def pdf_grey_checkbox(form_object, column)
    if form_object.object.send(column)
      html_element = form_object.check_box column, {class: 'css-checkboxGrey', checked: form_object.object.send(column)}
      html_element + content_tag(:label, nil, class: 'css-labelGrey')
    else
      html_element = form_object.check_box column, {class: 'css-checkboxGrey'}
      html_element + content_tag(:label, nil, class: 'css-labelGrey')
    end
  end

end