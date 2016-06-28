

json.id post.id
json.title post.title
json.content post.content
json.user do
  json.id post.user.id
  json.nickname post.user.nickname
  json.email post.user.email
end

json.created_at post.created_at
json.updated_at post.updated_at