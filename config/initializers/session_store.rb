require 'action_dispatch/middleware/session/dalli_store'
Crm::Application.config.session_store :dalli_store, :memcache_server => '127.0.0.1', :namespace => 'crm_sessions', :key => '_gift_crm_session', :expire_after => 180.minutes
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Crm::Application.config.session_store :active_record_store
