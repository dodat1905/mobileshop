json.notifications do
  json.array! @notifications do |notify|
    json.content notify.content
    json.url notify.order_url
    json.time notify.created_at
  end
end

json.unread @unread.count
