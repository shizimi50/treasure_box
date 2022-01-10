require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module E2rMini
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.middleware.use ActionDispatch::Cookies #cookie機能を提供
    # config.middleware.use ActionDispatch::Session::CookieStore #セッションをcookieに保存する役割を担当する
    config.middleware.use ActionDispatch::ContentSecurityPolicy::Middleware #Content-Security-Policyヘッダー設定用のDSLを提供
    # config.middleware.use ActionDispatch::Session::ActiveRecordStore #Active Recordを使用してデータベース内にデータを格納。 (activerecord-session_storeのGemが必要)
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = false #session storeをcookieにする場合、true にした上で必要なmiddle wearを読み込む
    config.action_controller.include_all_helpers = false
  end
end
