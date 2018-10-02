a = ["aaa","bbb","ccc"]

# json.text "テキスト3"

# for i in 0..2
#   json.key a[i]
# end

json.a do
  json.key a
end
