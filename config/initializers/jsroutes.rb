JsRoutes.setup do |config|
  config.serializer = <<~'JS'
    function(object) {
      object.locale = I18n.locale
      return Routes.default_serializer(object)
    }
  JS
end
