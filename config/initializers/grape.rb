GrapeSwaggerRails.options.url = "/api/v1/swagger_doc.json"
GrapeSwaggerRails.options.app_name = "Yaroom Manager"
unless Rails.env.production?
  GrapeSwaggerRails.options.app_url = "http://localhost:3000"
else 
  GrapeSwaggerRails.options.app_url = "http://http://104.131.146.193"
end
