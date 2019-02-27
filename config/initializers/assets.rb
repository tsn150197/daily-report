Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths +=
  Dir["#{Rails.root}/vendor/*"].sort_by { |dir| -dir.size }
Rails.application.config.assets.precompile += %w(theme1.js theme1.css)
Rails.application.config.assets.precompile += %w( ckeditor/*)
