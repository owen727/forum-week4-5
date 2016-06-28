json.data do
  json.array! @posts, :partial => "post", :as => :post
end

json.meta do
  json.current_page @posts.current_page
  json.total_pages @posts.total_pages
  json.per_page @posts.limit_value
  json.next_url (@posts.last_page?)? nil : v1_posts_url( :page => @posts.next_page )
  json.previous_url (@posts.first_page?)? nil : v1_posts_url( :page => @posts.prev_page )
end