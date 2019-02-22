Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths +=
  Dir["#{Rails.root}/vendor/*"].sort_by { |dir| -dir.size }
