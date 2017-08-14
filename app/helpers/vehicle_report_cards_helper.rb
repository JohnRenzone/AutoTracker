module VehicleReportCardsHelper
  def check_box_block(f, column)
    content_tag :div, class: f.object.send(column) ? 'checked check-box-block' : 'check-box-block' do
      element = content_tag(:i, nil, {class: 'fa fa-check'})
      element += f.check_box(column)
    end
  end

  def legend column, f, except = []
    except ||= []
    div = content_tag :div, class: "btn-group", data: {toggle: "buttons"} do
      label = ""

      {g: {class: "btn-success"}, y: {class: 'btn-warning'}, r: {class: 'btn-danger'}}.each_pair do |key, options|
        checked = f.object.send(column) == key.to_s
        label += content_tag :label, data: {toggle: 'tooltip', title: t("legend.#{key}")}, class: legend_label_class(key, options, checked, except) do
          f.radio_button(column, key, checked: checked) + content_tag(:i, ' ', class: "fa fa-check #{checked ? '' : 'invisible'}")
        end
      end
      label.html_safe
    end
    div
  end

  def legend_label_class(key, options, checked, except = [])
    "btn btn-lg mR10 #{options[:class]} #{checked or @vehicle_report_card.new_record? ? "" : "backgroundGrey"}" + (except.include?(key.to_sym) ? ' vHidden' : '') + (checked ? ' active' : '')
  end
end