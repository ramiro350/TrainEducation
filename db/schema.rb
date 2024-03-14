# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_14_135324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_event_entity", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.bigint "admin_event_time"
    t.string "realm_id", limit: 255
    t.string "operation_type", limit: 255
    t.string "auth_realm_id", limit: 255
    t.string "auth_client_id", limit: 255
    t.string "auth_user_id", limit: 255
    t.string "ip_address", limit: 255
    t.string "resource_path", limit: 2550
    t.text "representation"
    t.string "error", limit: 255
    t.string "resource_type", limit: 64
    t.index ["realm_id", "admin_event_time"], name: "idx_admin_event_time"
  end

  create_table "associated_policy", primary_key: ["policy_id", "associated_policy_id"], force: :cascade do |t|
    t.string "policy_id", limit: 36, null: false
    t.string "associated_policy_id", limit: 36, null: false
    t.index ["associated_policy_id"], name: "idx_assoc_pol_assoc_pol_id"
  end

  create_table "authentication_execution", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "alias", limit: 255
    t.string "authenticator", limit: 36
    t.string "realm_id", limit: 36
    t.string "flow_id", limit: 36
    t.integer "requirement"
    t.integer "priority"
    t.boolean "authenticator_flow", default: false, null: false
    t.string "auth_flow_id", limit: 36
    t.string "auth_config", limit: 36
    t.index ["flow_id"], name: "idx_auth_exec_flow"
    t.index ["realm_id", "flow_id"], name: "idx_auth_exec_realm_flow"
  end

  create_table "authentication_flow", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "alias", limit: 255
    t.string "description", limit: 255
    t.string "realm_id", limit: 36
    t.string "provider_id", limit: 36, default: "basic-flow", null: false
    t.boolean "top_level", default: false, null: false
    t.boolean "built_in", default: false, null: false
    t.index ["realm_id"], name: "idx_auth_flow_realm"
  end

  create_table "authenticator_config", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "alias", limit: 255
    t.string "realm_id", limit: 36
    t.index ["realm_id"], name: "idx_auth_config_realm"
  end

  create_table "authenticator_config_entry", primary_key: ["authenticator_id", "name"], force: :cascade do |t|
    t.string "authenticator_id", limit: 36, null: false
    t.text "value"
    t.string "name", limit: 255, null: false
  end

  create_table "broker_link", primary_key: ["identity_provider", "user_id"], force: :cascade do |t|
    t.string "identity_provider", limit: 255, null: false
    t.string "storage_provider_id", limit: 255
    t.string "realm_id", limit: 36, null: false
    t.string "broker_user_id", limit: 255
    t.string "broker_username", limit: 255
    t.text "token"
    t.string "user_id", limit: 255, null: false
  end

  create_table "client", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.boolean "enabled", default: false, null: false
    t.boolean "full_scope_allowed", default: false, null: false
    t.string "client_id", limit: 255
    t.integer "not_before"
    t.boolean "public_client", default: false, null: false
    t.string "secret", limit: 255
    t.string "base_url", limit: 255
    t.boolean "bearer_only", default: false, null: false
    t.string "management_url", limit: 255
    t.boolean "surrogate_auth_required", default: false, null: false
    t.string "realm_id", limit: 36
    t.string "protocol", limit: 255
    t.integer "node_rereg_timeout", default: 0
    t.boolean "frontchannel_logout", default: false, null: false
    t.boolean "consent_required", default: false, null: false
    t.string "name", limit: 255
    t.boolean "service_accounts_enabled", default: false, null: false
    t.string "client_authenticator_type", limit: 255
    t.string "root_url", limit: 255
    t.string "description", limit: 255
    t.string "registration_token", limit: 255
    t.boolean "standard_flow_enabled", default: true, null: false
    t.boolean "implicit_flow_enabled", default: false, null: false
    t.boolean "direct_access_grants_enabled", default: false, null: false
    t.boolean "always_display_in_console", default: false, null: false
    t.index ["client_id"], name: "idx_client_id"
    t.index ["realm_id", "client_id"], name: "uk_b71cjlbenv945rb6gcon438at", unique: true
  end

  create_table "client_attributes", primary_key: ["client_id", "name"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.string "name", limit: 255, null: false
    t.text "value"
  end

  create_table "client_auth_flow_bindings", primary_key: ["client_id", "binding_name"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.string "flow_id", limit: 36
    t.string "binding_name", limit: 255, null: false
  end

  create_table "client_initial_access", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.integer "timestamp"
    t.integer "expiration"
    t.integer "count"
    t.integer "remaining_count"
    t.index ["realm_id"], name: "idx_client_init_acc_realm"
  end

  create_table "client_node_registrations", primary_key: ["client_id", "name"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.integer "value"
    t.string "name", limit: 255, null: false
  end

  create_table "client_scope", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "realm_id", limit: 36
    t.string "description", limit: 255
    t.string "protocol", limit: 255
    t.index ["realm_id", "name"], name: "uk_cli_scope", unique: true
    t.index ["realm_id"], name: "idx_realm_clscope"
  end

  create_table "client_scope_attributes", primary_key: ["scope_id", "name"], force: :cascade do |t|
    t.string "scope_id", limit: 36, null: false
    t.string "value", limit: 2048
    t.string "name", limit: 255, null: false
    t.index ["scope_id"], name: "idx_clscope_attrs"
  end

  create_table "client_scope_client", primary_key: ["client_id", "scope_id"], force: :cascade do |t|
    t.string "client_id", limit: 255, null: false
    t.string "scope_id", limit: 255, null: false
    t.boolean "default_scope", default: false, null: false
    t.index ["client_id"], name: "idx_clscope_cl"
    t.index ["scope_id"], name: "idx_cl_clscope"
  end

  create_table "client_scope_role_mapping", primary_key: ["scope_id", "role_id"], force: :cascade do |t|
    t.string "scope_id", limit: 36, null: false
    t.string "role_id", limit: 36, null: false
    t.index ["role_id"], name: "idx_role_clscope"
    t.index ["scope_id"], name: "idx_clscope_role"
  end

  create_table "client_session", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "client_id", limit: 36
    t.string "redirect_uri", limit: 255
    t.string "state", limit: 255
    t.integer "timestamp"
    t.string "session_id", limit: 36
    t.string "auth_method", limit: 255
    t.string "realm_id", limit: 255
    t.string "auth_user_id", limit: 36
    t.string "current_action", limit: 36
    t.index ["session_id"], name: "idx_client_session_session"
  end

  create_table "client_session_auth_status", primary_key: ["client_session", "authenticator"], force: :cascade do |t|
    t.string "authenticator", limit: 36, null: false
    t.integer "status"
    t.string "client_session", limit: 36, null: false
  end

  create_table "client_session_note", primary_key: ["client_session", "name"], force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255
    t.string "client_session", limit: 36, null: false
  end

  create_table "client_session_prot_mapper", primary_key: ["client_session", "protocol_mapper_id"], force: :cascade do |t|
    t.string "protocol_mapper_id", limit: 36, null: false
    t.string "client_session", limit: 36, null: false
  end

  create_table "client_session_role", primary_key: ["client_session", "role_id"], force: :cascade do |t|
    t.string "role_id", limit: 255, null: false
    t.string "client_session", limit: 36, null: false
  end

  create_table "client_user_session_note", primary_key: ["client_session", "name"], force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 2048
    t.string "client_session", limit: 36, null: false
  end

  create_table "component", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "parent_id", limit: 36
    t.string "provider_id", limit: 36
    t.string "provider_type", limit: 255
    t.string "realm_id", limit: 36
    t.string "sub_type", limit: 255
    t.index ["provider_type"], name: "idx_component_provider_type"
    t.index ["realm_id"], name: "idx_component_realm"
  end

  create_table "component_config", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "component_id", limit: 36, null: false
    t.string "name", limit: 255, null: false
    t.text "value"
    t.index ["component_id"], name: "idx_compo_config_compo"
  end

  create_table "composite_role", primary_key: ["composite", "child_role"], force: :cascade do |t|
    t.string "composite", limit: 36, null: false
    t.string "child_role", limit: 36, null: false
    t.index ["child_role"], name: "idx_composite_child"
    t.index ["composite"], name: "idx_composite"
  end

  create_table "credential", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.binary "salt"
    t.string "type", limit: 255
    t.string "user_id", limit: 36
    t.bigint "created_date"
    t.string "user_label", limit: 255
    t.text "secret_data"
    t.text "credential_data"
    t.integer "priority"
    t.index ["user_id"], name: "idx_user_credential"
  end

  create_table "databasechangelog", id: false, force: :cascade do |t|
    t.string "id", limit: 255, null: false
    t.string "author", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.datetime "dateexecuted", precision: nil, null: false
    t.integer "orderexecuted", null: false
    t.string "exectype", limit: 10, null: false
    t.string "md5sum", limit: 35
    t.string "description", limit: 255
    t.string "comments", limit: 255
    t.string "tag", limit: 255
    t.string "liquibase", limit: 20
    t.string "contexts", limit: 255
    t.string "labels", limit: 255
    t.string "deployment_id", limit: 10
  end

  create_table "databasechangeloglock", id: :integer, default: nil, force: :cascade do |t|
    t.boolean "locked", null: false
    t.datetime "lockgranted", precision: nil
    t.string "lockedby", limit: 255
  end

  create_table "datasets", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "default_client_scope", primary_key: ["realm_id", "scope_id"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "scope_id", limit: 36, null: false
    t.boolean "default_scope", default: false, null: false
    t.index ["realm_id"], name: "idx_defcls_realm"
    t.index ["scope_id"], name: "idx_defcls_scope"
  end

  create_table "event_entity", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "client_id", limit: 255
    t.string "details_json", limit: 2550
    t.string "error", limit: 255
    t.string "ip_address", limit: 255
    t.string "realm_id", limit: 255
    t.string "session_id", limit: 255
    t.bigint "event_time"
    t.string "type", limit: 255
    t.string "user_id", limit: 255
    t.text "details_json_long_value"
    t.index ["realm_id", "event_time"], name: "idx_event_time"
  end

  create_table "fed_user_attribute", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.string "value", limit: 2024
    t.index ["user_id", "realm_id", "name"], name: "idx_fu_attribute"
  end

  create_table "fed_user_consent", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "client_id", limit: 255
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.bigint "created_date"
    t.bigint "last_updated_date"
    t.string "client_storage_provider", limit: 36
    t.string "external_client_id", limit: 255
    t.index ["realm_id", "user_id"], name: "idx_fu_consent_ru"
    t.index ["user_id", "client_id"], name: "idx_fu_consent"
    t.index ["user_id", "client_storage_provider", "external_client_id"], name: "idx_fu_cnsnt_ext"
  end

  create_table "fed_user_consent_cl_scope", primary_key: ["user_consent_id", "scope_id"], force: :cascade do |t|
    t.string "user_consent_id", limit: 36, null: false
    t.string "scope_id", limit: 36, null: false
  end

  create_table "fed_user_credential", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.binary "salt"
    t.string "type", limit: 255
    t.bigint "created_date"
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.string "user_label", limit: 255
    t.text "secret_data"
    t.text "credential_data"
    t.integer "priority"
    t.index ["realm_id", "user_id"], name: "idx_fu_credential_ru"
    t.index ["user_id", "type"], name: "idx_fu_credential"
  end

  create_table "fed_user_group_membership", primary_key: ["group_id", "user_id"], force: :cascade do |t|
    t.string "group_id", limit: 36, null: false
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.index ["realm_id", "user_id"], name: "idx_fu_group_membership_ru"
    t.index ["user_id", "group_id"], name: "idx_fu_group_membership"
  end

  create_table "fed_user_required_action", primary_key: ["required_action", "user_id"], force: :cascade do |t|
    t.string "required_action", limit: 255, default: " ", null: false
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.index ["realm_id", "user_id"], name: "idx_fu_required_action_ru"
    t.index ["user_id", "required_action"], name: "idx_fu_required_action"
  end

  create_table "fed_user_role_mapping", primary_key: ["role_id", "user_id"], force: :cascade do |t|
    t.string "role_id", limit: 36, null: false
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.string "storage_provider_id", limit: 36
    t.index ["realm_id", "user_id"], name: "idx_fu_role_mapping_ru"
    t.index ["user_id", "role_id"], name: "idx_fu_role_mapping"
  end

  create_table "federated_identity", primary_key: ["identity_provider", "user_id"], force: :cascade do |t|
    t.string "identity_provider", limit: 255, null: false
    t.string "realm_id", limit: 36
    t.string "federated_user_id", limit: 255
    t.string "federated_username", limit: 255
    t.text "token"
    t.string "user_id", limit: 36, null: false
    t.index ["federated_user_id"], name: "idx_fedidentity_feduser"
    t.index ["user_id"], name: "idx_fedidentity_user"
  end

  create_table "federated_user", id: { type: :string, limit: 255 }, force: :cascade do |t|
    t.string "storage_provider_id", limit: 255
    t.string "realm_id", limit: 36, null: false
  end

  create_table "group_attribute", id: { type: :string, limit: 36, default: "sybase-needs-something-here" }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255
    t.string "group_id", limit: 36, null: false
    t.index "name, ((value)::character varying(250))", name: "idx_group_att_by_name_value"
    t.index ["group_id"], name: "idx_group_attr_group"
  end

  create_table "group_role_mapping", primary_key: ["role_id", "group_id"], force: :cascade do |t|
    t.string "role_id", limit: 36, null: false
    t.string "group_id", limit: 36, null: false
    t.index ["group_id"], name: "idx_group_role_mapp_group"
  end

  create_table "identity_provider", primary_key: "internal_id", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.boolean "enabled", default: false, null: false
    t.string "provider_alias", limit: 255
    t.string "provider_id", limit: 255
    t.boolean "store_token", default: false, null: false
    t.boolean "authenticate_by_default", default: false, null: false
    t.string "realm_id", limit: 36
    t.boolean "add_token_role", default: true, null: false
    t.boolean "trust_email", default: false, null: false
    t.string "first_broker_login_flow_id", limit: 36
    t.string "post_broker_login_flow_id", limit: 36
    t.string "provider_display_name", limit: 255
    t.boolean "link_only", default: false, null: false
    t.index ["provider_alias", "realm_id"], name: "uk_2daelwnibji49avxsrtuf6xj33", unique: true
    t.index ["realm_id"], name: "idx_ident_prov_realm"
  end

  create_table "identity_provider_config", primary_key: ["identity_provider_id", "name"], force: :cascade do |t|
    t.string "identity_provider_id", limit: 36, null: false
    t.text "value"
    t.string "name", limit: 255, null: false
  end

  create_table "identity_provider_mapper", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "idp_alias", limit: 255, null: false
    t.string "idp_mapper_name", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.index ["realm_id"], name: "idx_id_prov_mapp_realm"
  end

  create_table "idp_mapper_config", primary_key: ["idp_mapper_id", "name"], force: :cascade do |t|
    t.string "idp_mapper_id", limit: 36, null: false
    t.text "value"
    t.string "name", limit: 255, null: false
  end

  create_table "keycloak_group", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "parent_group", limit: 36, null: false
    t.string "realm_id", limit: 36
    t.index ["realm_id", "parent_group", "name"], name: "sibling_names", unique: true
  end

  create_table "keycloak_role", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "client_realm_constraint", limit: 255
    t.boolean "client_role", default: false, null: false
    t.string "description", limit: 255
    t.string "name", limit: 255
    t.string "realm_id", limit: 255
    t.string "client", limit: 36
    t.string "realm", limit: 36
    t.index ["client"], name: "idx_keycloak_role_client"
    t.index ["name", "client_realm_constraint"], name: "UK_J3RWUVD56ONTGSUHOGM184WW2-2", unique: true
    t.index ["realm"], name: "idx_keycloak_role_realm"
  end

  create_table "migration_model", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "version", limit: 36
    t.bigint "update_time", default: 0, null: false
    t.index ["update_time"], name: "idx_update_time"
  end

  create_table "offline_client_session", primary_key: ["user_session_id", "client_id", "client_storage_provider", "external_client_id", "offline_flag"], force: :cascade do |t|
    t.string "user_session_id", limit: 36, null: false
    t.string "client_id", limit: 255, null: false
    t.string "offline_flag", limit: 4, null: false
    t.integer "timestamp"
    t.text "data"
    t.string "client_storage_provider", limit: 36, default: "local", null: false
    t.string "external_client_id", limit: 255, default: "local", null: false
    t.index ["client_id", "offline_flag"], name: "idx_offline_css_preload"
    t.index ["user_session_id"], name: "idx_us_sess_id_on_cl_sess"
  end

  create_table "offline_user_session", primary_key: ["user_session_id", "offline_flag"], force: :cascade do |t|
    t.string "user_session_id", limit: 36, null: false
    t.string "user_id", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.integer "created_on", null: false
    t.string "offline_flag", limit: 4, null: false
    t.text "data"
    t.integer "last_session_refresh", default: 0, null: false
    t.index ["created_on"], name: "idx_offline_uss_createdon"
    t.index ["offline_flag", "created_on", "user_session_id"], name: "idx_offline_uss_preload"
    t.index ["realm_id", "offline_flag", "user_session_id"], name: "idx_offline_uss_by_usersess"
    t.index ["user_id", "realm_id", "offline_flag"], name: "idx_offline_uss_by_user"
  end

  create_table "policy_config", primary_key: ["policy_id", "name"], force: :cascade do |t|
    t.string "policy_id", limit: 36, null: false
    t.string "name", limit: 255, null: false
    t.text "value"
  end

  create_table "protocol_mapper", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "protocol", limit: 255, null: false
    t.string "protocol_mapper_name", limit: 255, null: false
    t.string "client_id", limit: 36
    t.string "client_scope_id", limit: 36
    t.index ["client_id"], name: "idx_protocol_mapper_client"
    t.index ["client_scope_id"], name: "idx_clscope_protmap"
  end

  create_table "protocol_mapper_config", primary_key: ["protocol_mapper_id", "name"], force: :cascade do |t|
    t.string "protocol_mapper_id", limit: 36, null: false
    t.text "value"
    t.string "name", limit: 255, null: false
  end

  create_table "realm", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.integer "access_code_lifespan"
    t.integer "user_action_lifespan"
    t.integer "access_token_lifespan"
    t.string "account_theme", limit: 255
    t.string "admin_theme", limit: 255
    t.string "email_theme", limit: 255
    t.boolean "enabled", default: false, null: false
    t.boolean "events_enabled", default: false, null: false
    t.bigint "events_expiration"
    t.string "login_theme", limit: 255
    t.string "name", limit: 255
    t.integer "not_before"
    t.string "password_policy", limit: 2550
    t.boolean "registration_allowed", default: false, null: false
    t.boolean "remember_me", default: false, null: false
    t.boolean "reset_password_allowed", default: false, null: false
    t.boolean "social", default: false, null: false
    t.string "ssl_required", limit: 255
    t.integer "sso_idle_timeout"
    t.integer "sso_max_lifespan"
    t.boolean "update_profile_on_soc_login", default: false, null: false
    t.boolean "verify_email", default: false, null: false
    t.string "master_admin_client", limit: 36
    t.integer "login_lifespan"
    t.boolean "internationalization_enabled", default: false, null: false
    t.string "default_locale", limit: 255
    t.boolean "reg_email_as_username", default: false, null: false
    t.boolean "admin_events_enabled", default: false, null: false
    t.boolean "admin_events_details_enabled", default: false, null: false
    t.boolean "edit_username_allowed", default: false, null: false
    t.integer "otp_policy_counter", default: 0
    t.integer "otp_policy_window", default: 1
    t.integer "otp_policy_period", default: 30
    t.integer "otp_policy_digits", default: 6
    t.string "otp_policy_alg", limit: 36, default: "HmacSHA1"
    t.string "otp_policy_type", limit: 36, default: "totp"
    t.string "browser_flow", limit: 36
    t.string "registration_flow", limit: 36
    t.string "direct_grant_flow", limit: 36
    t.string "reset_credentials_flow", limit: 36
    t.string "client_auth_flow", limit: 36
    t.integer "offline_session_idle_timeout", default: 0
    t.boolean "revoke_refresh_token", default: false, null: false
    t.integer "access_token_life_implicit", default: 0
    t.boolean "login_with_email_allowed", default: true, null: false
    t.boolean "duplicate_emails_allowed", default: false, null: false
    t.string "docker_auth_flow", limit: 36
    t.integer "refresh_token_max_reuse", default: 0
    t.boolean "allow_user_managed_access", default: false, null: false
    t.integer "sso_max_lifespan_remember_me", default: 0, null: false
    t.integer "sso_idle_timeout_remember_me", default: 0, null: false
    t.string "default_role", limit: 255
    t.index ["master_admin_client"], name: "idx_realm_master_adm_cli"
    t.index ["name"], name: "uk_orvsdmla56612eaefiq6wl5oi", unique: true
  end

  create_table "realm_attribute", primary_key: ["name", "realm_id"], force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.text "value"
    t.index ["realm_id"], name: "idx_realm_attr_realm"
  end

  create_table "realm_default_groups", primary_key: ["realm_id", "group_id"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "group_id", limit: 36, null: false
    t.index ["group_id"], name: "con_group_id_def_groups", unique: true
    t.index ["realm_id"], name: "idx_realm_def_grp_realm"
  end

  create_table "realm_enabled_event_types", primary_key: ["realm_id", "value"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
    t.index ["realm_id"], name: "idx_realm_evt_types_realm"
  end

  create_table "realm_events_listeners", primary_key: ["realm_id", "value"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
    t.index ["realm_id"], name: "idx_realm_evt_list_realm"
  end

  create_table "realm_localizations", primary_key: ["realm_id", "locale"], force: :cascade do |t|
    t.string "realm_id", limit: 255, null: false
    t.string "locale", limit: 255, null: false
    t.text "texts", null: false
  end

  create_table "realm_required_credential", primary_key: ["realm_id", "type"], force: :cascade do |t|
    t.string "type", limit: 255, null: false
    t.string "form_label", limit: 255
    t.boolean "input", default: false, null: false
    t.boolean "secret", default: false, null: false
    t.string "realm_id", limit: 36, null: false
  end

  create_table "realm_smtp_config", primary_key: ["realm_id", "name"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "value", limit: 255
    t.string "name", limit: 255, null: false
  end

  create_table "realm_supported_locales", primary_key: ["realm_id", "value"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
    t.index ["realm_id"], name: "idx_realm_supp_local_realm"
  end

  create_table "redirect_uris", primary_key: ["client_id", "value"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
    t.index ["client_id"], name: "idx_redir_uri_client"
  end

  create_table "required_action_config", primary_key: ["required_action_id", "name"], force: :cascade do |t|
    t.string "required_action_id", limit: 36, null: false
    t.text "value"
    t.string "name", limit: 255, null: false
  end

  create_table "required_action_provider", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "alias", limit: 255
    t.string "name", limit: 255
    t.string "realm_id", limit: 36
    t.boolean "enabled", default: false, null: false
    t.boolean "default_action", default: false, null: false
    t.string "provider_id", limit: 255
    t.integer "priority"
    t.index ["realm_id"], name: "idx_req_act_prov_realm"
  end

  create_table "resource_attribute", id: { type: :string, limit: 36, default: "sybase-needs-something-here" }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255
    t.string "resource_id", limit: 36, null: false
  end

  create_table "resource_policy", primary_key: ["resource_id", "policy_id"], force: :cascade do |t|
    t.string "resource_id", limit: 36, null: false
    t.string "policy_id", limit: 36, null: false
    t.index ["policy_id"], name: "idx_res_policy_policy"
  end

  create_table "resource_scope", primary_key: ["resource_id", "scope_id"], force: :cascade do |t|
    t.string "resource_id", limit: 36, null: false
    t.string "scope_id", limit: 36, null: false
    t.index ["scope_id"], name: "idx_res_scope_scope"
  end

  create_table "resource_server", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.boolean "allow_rs_remote_mgmt", default: false, null: false
    t.integer "policy_enforce_mode", limit: 2, null: false
    t.integer "decision_strategy", limit: 2, default: 1, null: false
  end

  create_table "resource_server_perm_ticket", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "owner", limit: 255, null: false
    t.string "requester", limit: 255, null: false
    t.bigint "created_timestamp", null: false
    t.bigint "granted_timestamp"
    t.string "resource_id", limit: 36, null: false
    t.string "scope_id", limit: 36
    t.string "resource_server_id", limit: 36, null: false
    t.string "policy_id", limit: 36
    t.index ["owner", "requester", "resource_server_id", "resource_id", "scope_id"], name: "uk_frsr6t700s9v50bu18ws5pmt", unique: true
  end

  create_table "resource_server_policy", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "description", limit: 255
    t.string "type", limit: 255, null: false
    t.integer "decision_strategy", limit: 2
    t.integer "logic", limit: 2
    t.string "resource_server_id", limit: 36, null: false
    t.string "owner", limit: 255
    t.index ["name", "resource_server_id"], name: "uk_frsrpt700s9v50bu18ws5ha6", unique: true
    t.index ["resource_server_id"], name: "idx_res_serv_pol_res_serv"
  end

  create_table "resource_server_resource", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "type", limit: 255
    t.string "icon_uri", limit: 255
    t.string "owner", limit: 255, null: false
    t.string "resource_server_id", limit: 36, null: false
    t.boolean "owner_managed_access", default: false, null: false
    t.string "display_name", limit: 255
    t.index ["name", "owner", "resource_server_id"], name: "uk_frsr6t700s9v50bu18ws5ha6", unique: true
    t.index ["resource_server_id"], name: "idx_res_srv_res_res_srv"
  end

  create_table "resource_server_scope", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "icon_uri", limit: 255
    t.string "resource_server_id", limit: 36, null: false
    t.string "display_name", limit: 255
    t.index ["name", "resource_server_id"], name: "uk_frsrst700s9v50bu18ws5ha6", unique: true
    t.index ["resource_server_id"], name: "idx_res_srv_scope_res_srv"
  end

  create_table "resource_uris", primary_key: ["resource_id", "value"], force: :cascade do |t|
    t.string "resource_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
  end

  create_table "role_attribute", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "role_id", limit: 36, null: false
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255
    t.index ["role_id"], name: "idx_role_attribute"
  end

  create_table "scope_mapping", primary_key: ["client_id", "role_id"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.string "role_id", limit: 36, null: false
    t.index ["role_id"], name: "idx_scope_mapping_role"
  end

  create_table "scope_policy", primary_key: ["scope_id", "policy_id"], force: :cascade do |t|
    t.string "scope_id", limit: 36, null: false
    t.string "policy_id", limit: 36, null: false
    t.index ["policy_id"], name: "idx_scope_policy_policy"
  end

  create_table "user_attribute", id: { type: :string, limit: 36, default: "sybase-needs-something-here" }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "value", limit: 255
    t.string "user_id", limit: 36, null: false
    t.index ["name", "value"], name: "idx_user_attribute_name"
    t.index ["user_id"], name: "idx_user_attribute"
  end

  create_table "user_consent", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "client_id", limit: 255
    t.string "user_id", limit: 36, null: false
    t.bigint "created_date"
    t.bigint "last_updated_date"
    t.string "client_storage_provider", limit: 36
    t.string "external_client_id", limit: 255
    t.index ["client_id", "client_storage_provider", "external_client_id", "user_id"], name: "uk_jkuwuvd56ontgsuhogm8uewrt", unique: true
    t.index ["user_id"], name: "idx_user_consent"
  end

  create_table "user_consent_client_scope", primary_key: ["user_consent_id", "scope_id"], force: :cascade do |t|
    t.string "user_consent_id", limit: 36, null: false
    t.string "scope_id", limit: 36, null: false
    t.index ["user_consent_id"], name: "idx_usconsent_clscope"
  end

  create_table "user_entity", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "email_constraint", limit: 255
    t.boolean "email_verified", default: false, null: false
    t.boolean "enabled", default: false, null: false
    t.string "federation_link", limit: 255
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "realm_id", limit: 255
    t.string "username", limit: 255
    t.bigint "created_timestamp"
    t.string "service_account_client_link", limit: 255
    t.integer "not_before", default: 0, null: false
    t.index ["email"], name: "idx_user_email"
    t.index ["realm_id", "email_constraint"], name: "uk_dykn684sl8up1crfei6eckhd7", unique: true
    t.index ["realm_id", "service_account_client_link"], name: "idx_user_service_account"
    t.index ["realm_id", "username"], name: "uk_ru8tt6t700s9v50bu18ws5ha6", unique: true
  end

  create_table "user_federation_config", primary_key: ["user_federation_provider_id", "name"], force: :cascade do |t|
    t.string "user_federation_provider_id", limit: 36, null: false
    t.string "value", limit: 255
    t.string "name", limit: 255, null: false
  end

  create_table "user_federation_mapper", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "federation_provider_id", limit: 36, null: false
    t.string "federation_mapper_type", limit: 255, null: false
    t.string "realm_id", limit: 36, null: false
    t.index ["federation_provider_id"], name: "idx_usr_fed_map_fed_prv"
    t.index ["realm_id"], name: "idx_usr_fed_map_realm"
  end

  create_table "user_federation_mapper_config", primary_key: ["user_federation_mapper_id", "name"], force: :cascade do |t|
    t.string "user_federation_mapper_id", limit: 36, null: false
    t.string "value", limit: 255
    t.string "name", limit: 255, null: false
  end

  create_table "user_federation_provider", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.integer "changed_sync_period"
    t.string "display_name", limit: 255
    t.integer "full_sync_period"
    t.integer "last_sync"
    t.integer "priority"
    t.string "provider_name", limit: 255
    t.string "realm_id", limit: 36
    t.index ["realm_id"], name: "idx_usr_fed_prv_realm"
  end

  create_table "user_group_membership", primary_key: ["group_id", "user_id"], force: :cascade do |t|
    t.string "group_id", limit: 36, null: false
    t.string "user_id", limit: 36, null: false
    t.index ["user_id"], name: "idx_user_group_mapping"
  end

  create_table "user_required_action", primary_key: ["required_action", "user_id"], force: :cascade do |t|
    t.string "user_id", limit: 36, null: false
    t.string "required_action", limit: 255, default: " ", null: false
    t.index ["user_id"], name: "idx_user_reqactions"
  end

  create_table "user_role_mapping", primary_key: ["role_id", "user_id"], force: :cascade do |t|
    t.string "role_id", limit: 255, null: false
    t.string "user_id", limit: 36, null: false
    t.index ["user_id"], name: "idx_user_role_mapping"
  end

  create_table "user_session", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "auth_method", limit: 255
    t.string "ip_address", limit: 255
    t.integer "last_session_refresh"
    t.string "login_username", limit: 255
    t.string "realm_id", limit: 255
    t.boolean "remember_me", default: false, null: false
    t.integer "started"
    t.string "user_id", limit: 255
    t.integer "user_session_state"
    t.string "broker_session_id", limit: 255
    t.string "broker_user_id", limit: 255
  end

  create_table "user_session_note", primary_key: ["user_session", "name"], force: :cascade do |t|
    t.string "user_session", limit: 36, null: false
    t.string "name", limit: 255, null: false
    t.string "value", limit: 2048
  end

  create_table "username_login_failure", primary_key: ["realm_id", "username"], force: :cascade do |t|
    t.string "realm_id", limit: 36, null: false
    t.string "username", limit: 255, null: false
    t.integer "failed_login_not_before"
    t.bigint "last_failure"
    t.string "last_ip_failure", limit: 255
    t.integer "num_failures"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "roles", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "web_origins", primary_key: ["client_id", "value"], force: :cascade do |t|
    t.string "client_id", limit: 36, null: false
    t.string "value", limit: 255, null: false
    t.index ["client_id"], name: "idx_web_orig_client"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "associated_policy", "resource_server_policy", column: "associated_policy_id", name: "fk_frsr5s213xcx4wnkog82ssrfy"
  add_foreign_key "associated_policy", "resource_server_policy", column: "policy_id", name: "fk_frsrpas14xcx4wnkog82ssrfy"
  add_foreign_key "authentication_execution", "authentication_flow", column: "flow_id", name: "fk_auth_exec_flow"
  add_foreign_key "authentication_execution", "realm", name: "fk_auth_exec_realm"
  add_foreign_key "authentication_flow", "realm", name: "fk_auth_flow_realm"
  add_foreign_key "authenticator_config", "realm", name: "fk_auth_realm"
  add_foreign_key "client_attributes", "client", name: "fk3c47c64beacca966"
  add_foreign_key "client_initial_access", "realm", name: "fk_client_init_acc_realm"
  add_foreign_key "client_node_registrations", "client", name: "fk4129723ba992f594"
  add_foreign_key "client_scope_attributes", "client_scope", column: "scope_id", name: "fk_cl_scope_attr_scope"
  add_foreign_key "client_scope_role_mapping", "client_scope", column: "scope_id", name: "fk_cl_scope_rm_scope"
  add_foreign_key "client_session", "user_session", column: "session_id", name: "fk_b4ao2vcvat6ukau74wbwtfqo1"
  add_foreign_key "client_session_auth_status", "client_session", column: "client_session", name: "auth_status_constraint"
  add_foreign_key "client_session_note", "client_session", column: "client_session", name: "fk5edfb00ff51c2736"
  add_foreign_key "client_session_prot_mapper", "client_session", column: "client_session", name: "fk_33a8sgqw18i532811v7o2dk89"
  add_foreign_key "client_session_role", "client_session", column: "client_session", name: "fk_11b7sgqw18i532811v7o2dv76"
  add_foreign_key "client_user_session_note", "client_session", column: "client_session", name: "fk_cl_usr_ses_note"
  add_foreign_key "component", "realm", name: "fk_component_realm"
  add_foreign_key "component_config", "component", name: "fk_component_config"
  add_foreign_key "composite_role", "keycloak_role", column: "child_role", name: "fk_gr7thllb9lu8q4vqa4524jjy8"
  add_foreign_key "composite_role", "keycloak_role", column: "composite", name: "fk_a63wvekftu8jo1pnj81e7mce2"
  add_foreign_key "credential", "user_entity", column: "user_id", name: "fk_pfyr0glasqyl0dei3kl69r6v0"
  add_foreign_key "default_client_scope", "realm", name: "fk_r_def_cli_scope_realm"
  add_foreign_key "federated_identity", "user_entity", column: "user_id", name: "fk404288b92ef007a6"
  add_foreign_key "group_attribute", "keycloak_group", column: "group_id", name: "fk_group_attribute_group"
  add_foreign_key "group_role_mapping", "keycloak_group", column: "group_id", name: "fk_group_role_group"
  add_foreign_key "identity_provider", "realm", name: "fk2b4ebc52ae5c3b34"
  add_foreign_key "identity_provider_config", "identity_provider", primary_key: "internal_id", name: "fkdc4897cf864c4e43"
  add_foreign_key "identity_provider_mapper", "realm", name: "fk_idpm_realm"
  add_foreign_key "idp_mapper_config", "identity_provider_mapper", column: "idp_mapper_id", name: "fk_idpmconfig"
  add_foreign_key "keycloak_role", "realm", column: "realm", name: "fk_6vyqfe4cn4wlq8r6kt5vdsj5c"
  add_foreign_key "policy_config", "resource_server_policy", column: "policy_id", name: "fkdc34197cf864c4e43"
  add_foreign_key "protocol_mapper", "client", name: "fk_pcm_realm"
  add_foreign_key "protocol_mapper", "client_scope", name: "fk_cli_scope_mapper"
  add_foreign_key "protocol_mapper_config", "protocol_mapper", name: "fk_pmconfig"
  add_foreign_key "realm_attribute", "realm", name: "fk_8shxd6l3e9atqukacxgpffptw"
  add_foreign_key "realm_default_groups", "realm", name: "fk_def_groups_realm"
  add_foreign_key "realm_enabled_event_types", "realm", name: "fk_h846o4h0w8epx5nwedrf5y69j"
  add_foreign_key "realm_events_listeners", "realm", name: "fk_h846o4h0w8epx5nxev9f5y69j"
  add_foreign_key "realm_required_credential", "realm", name: "fk_5hg65lybevavkqfki3kponh9v"
  add_foreign_key "realm_smtp_config", "realm", name: "fk_70ej8xdxgxd0b9hh6180irr0o"
  add_foreign_key "realm_supported_locales", "realm", name: "fk_supported_locales_realm"
  add_foreign_key "redirect_uris", "client", name: "fk_1burs8pb4ouj97h5wuppahv9f"
  add_foreign_key "required_action_provider", "realm", name: "fk_req_act_realm"
  add_foreign_key "resource_attribute", "resource_server_resource", column: "resource_id", name: "fk_5hrm2vlf9ql5fu022kqepovbr"
  add_foreign_key "resource_policy", "resource_server_policy", column: "policy_id", name: "fk_frsrpp213xcx4wnkog82ssrfy"
  add_foreign_key "resource_policy", "resource_server_resource", column: "resource_id", name: "fk_frsrpos53xcx4wnkog82ssrfy"
  add_foreign_key "resource_scope", "resource_server_resource", column: "resource_id", name: "fk_frsrpos13xcx4wnkog82ssrfy"
  add_foreign_key "resource_scope", "resource_server_scope", column: "scope_id", name: "fk_frsrps213xcx4wnkog82ssrfy"
  add_foreign_key "resource_server_perm_ticket", "resource_server", name: "fk_frsrho213xcx4wnkog82sspmt"
  add_foreign_key "resource_server_perm_ticket", "resource_server_policy", column: "policy_id", name: "fk_frsrpo2128cx4wnkog82ssrfy"
  add_foreign_key "resource_server_perm_ticket", "resource_server_resource", column: "resource_id", name: "fk_frsrho213xcx4wnkog83sspmt"
  add_foreign_key "resource_server_perm_ticket", "resource_server_scope", column: "scope_id", name: "fk_frsrho213xcx4wnkog84sspmt"
  add_foreign_key "resource_server_policy", "resource_server", name: "fk_frsrpo213xcx4wnkog82ssrfy"
  add_foreign_key "resource_server_resource", "resource_server", name: "fk_frsrho213xcx4wnkog82ssrfy"
  add_foreign_key "resource_server_scope", "resource_server", name: "fk_frsrso213xcx4wnkog82ssrfy"
  add_foreign_key "resource_uris", "resource_server_resource", column: "resource_id", name: "fk_resource_server_uris"
  add_foreign_key "role_attribute", "keycloak_role", column: "role_id", name: "fk_role_attribute_id"
  add_foreign_key "scope_mapping", "client", name: "fk_ouse064plmlr732lxjcn1q5f1"
  add_foreign_key "scope_policy", "resource_server_policy", column: "policy_id", name: "fk_frsrasp13xcx4wnkog82ssrfy"
  add_foreign_key "scope_policy", "resource_server_scope", column: "scope_id", name: "fk_frsrpass3xcx4wnkog82ssrfy"
  add_foreign_key "user_attribute", "user_entity", column: "user_id", name: "fk_5hrm2vlf9ql5fu043kqepovbr"
  add_foreign_key "user_consent", "user_entity", column: "user_id", name: "fk_grntcsnt_user"
  add_foreign_key "user_consent_client_scope", "user_consent", name: "fk_grntcsnt_clsc_usc"
  add_foreign_key "user_federation_config", "user_federation_provider", name: "fk_t13hpu1j94r2ebpekr39x5eu5"
  add_foreign_key "user_federation_mapper", "realm", name: "fk_fedmapperpm_realm"
  add_foreign_key "user_federation_mapper", "user_federation_provider", column: "federation_provider_id", name: "fk_fedmapperpm_fedprv"
  add_foreign_key "user_federation_mapper_config", "user_federation_mapper", name: "fk_fedmapper_cfg"
  add_foreign_key "user_federation_provider", "realm", name: "fk_1fj32f6ptolw2qy60cd8n01e8"
  add_foreign_key "user_group_membership", "user_entity", column: "user_id", name: "fk_user_group_user"
  add_foreign_key "user_required_action", "user_entity", column: "user_id", name: "fk_6qj3w1jw9cvafhe19bwsiuvmd"
  add_foreign_key "user_role_mapping", "user_entity", column: "user_id", name: "fk_c4fqv34p1mbylloxang7b1q3l"
  add_foreign_key "user_session_note", "user_session", column: "user_session", name: "fk5edfb00ff51d3472"
  add_foreign_key "web_origins", "client", name: "fk_lojpho213xcx4wnkog82ssrfy"
end
