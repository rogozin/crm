#encoding:utf-8;
module ApplicationHelper
  def  checked_box_image(checked=false,id=nil)
      image_tag(checked ? 'checked.gif' : 'unchecked.gif', :id=>id) 
  end

  def sort_column(column_name, label)
    direction_label = " "
    direction_label = (current_direction == "desc" ? " (Я-А)" : " (А-Я)") if params[:sort].to_s == column_name.to_s
    link_to(label + direction_label , params.merge({:sort => column_name, :direction => reverse_direction}))
  end

  def current_direction
     %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  def reverse_direction
     current_direction == "asc" ? "desc" : "asc"
  end

    def tab(*args)
    options = {:label => args.first.to_s}
    if args.last.is_a?(Hash)
      options = options.merge(args.pop)
    end
    options[:route] ||=  args.first
    destination_url =  options[:url] ? options[:url] : send("#{options[:route]}_path")

   # return("") unless current_user

    ## if more than one form, it'll capitalize all words
    label_with_first_letters_capitalized = options[:label].gsub(/\b\w/){$&.upcase}
    link = link_to(label_with_first_letters_capitalized, destination_url)

    css_classes = []

    selected = if options[:pattern]
      request.fullpath =~ options[:pattern]
    elsif options[:match_path]
      request.fullpath.starts_with?(options[:match_path])
    elsif options[:url]
      request.fullpath.starts_with?(options[:url])
    else
      args.include?(controller.controller_name.to_sym)
    end
    css_classes << 'selected' if selected

    if options[:css_class]
      css_classes << options[:css_class]
    end
    content_tag('li', link, :class => css_classes.join(' '))
  end
end
