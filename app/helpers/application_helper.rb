module ApplicationHelper
  def full_title(page_title)
    base_title = "The McGaheysville - Massanutten Lions Club"
    if page_title.empty?
      base_title
    else
      "#{base_title} ::: #{page_title}"
    end
  end


  def status_tag(boolean, options={})
    options[:true] ||= ''
    options[:true_class] ||= 'icon-eye-open'
    options[:false] ||= ''
    options[:false_class] ||= 'icon-eye-close'

    if boolean
      content_tag(:i, options[:true], :class => options[:true_class])
    else
      content_tag(:i, options[:false], :class => options[:false_class])
    end
  end

  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => object})
  end


end
