module ApplicationHelper
    def full_title(page_title)
        base_title = "Young Bankers Connect"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def comment
    end

    def time_string time
       time.strftime("%M:%H %d/%m/%y")  
    end
    def divider(size_col)
        ' <!-- DIVIDER -->
              <div class="' + size_col.to_s + ' border-bottom" style="margin-bottom: 15px; border-bottom: 1px solid #ccc;" >
              </div> 
          <!-- /DIVIDER -->'
    end

    def breadcrumb(hash) 
        html = "<ol class=\"breadcrumb\">"
        hash.each do |h|
            if h.equal? hash.last
                html << "<li class=\"active\"> #{h[:name]} </li>"
            else
                html << "<li>" + link_to(h[:name], h[:path]) + "</li>"
            end
        end
        html << "</ol>"
        html.html_safe
    end
end
