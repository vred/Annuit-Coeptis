module ViewHelper
  def ul_list_content_tags (items, ul_class = nil, li_class = nil)
    content_tag(:ul,nil,:class => ul_class) do
      items.collect { |item|
        logger.info(concat(content_tag(:li,item, :class => li_class)))
      }
    end
  end
end
