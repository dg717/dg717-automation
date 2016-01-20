json.array!(@events) do |event|
  json.extract! event, :id, :name, :from, :to, :type, :description, :subtext, :image
  json.url event_url(event, format: :json)
end
