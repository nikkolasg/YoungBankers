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

    def divider(size_col)
        ' <!-- DIVIDER -->
              <div class="' + size_col.to_s + ' border-bottom" style="margin-bottom: 15px; border-bottom: 1px solid #ccc;" >
              </div> 
          <!-- /DIVIDER -->'
    end
end
