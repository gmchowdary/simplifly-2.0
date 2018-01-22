# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171228080835) do

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token", limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "vendor_id"
    t.integer "corporate_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admin_users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "admin_user_id"
    t.bigint "role_id"
    t.index ["admin_user_id", "role_id"], name: "index_admin_users_roles_on_admin_user_id_and_role_id"
    t.index ["admin_user_id"], name: "index_admin_users_roles_on_admin_user_id"
    t.index ["role_id"], name: "index_admin_users_roles_on_role_id"
  end

  create_table "airlines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airport_codes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "identity"
    t.string "airport_type"
    t.string "name"
    t.string "latitude_deg"
    t.string "longitude_deg"
    t.integer "elevation_ft"
    t.string "continent"
    t.string "iso_country"
    t.string "iso_region"
    t.string "municipality"
    t.string "gps_code"
    t.string "iata_code"
    t.string "local_code"
    t.boolean "is_schengen", default: false
  end

  create_table "airports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ap_code"
    t.string "ap_name"
    t.string "status"
    t.string "time_zone"
    t.integer "country_id"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cabin_classes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tp_restrctn_id"
    t.integer "tp_al_cabin_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vendor_id"
    t.integer "corporate_id"
    t.string "first_name"
    t.string "last_name"
    t.string "phn_number"
    t.integer "contactable_person_id"
    t.string "contactable_person_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_id"
    t.index ["contactable_person_type", "contactable_person_id"], name: "my_index"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "addr1"
    t.string "addr2"
    t.string "district"
    t.string "city"
    t.string "state"
    t.integer "country_id"
    t.string "pincode"
    t.string "phone_num"
    t.string "email_id"
    t.string "last_action"
    t.integer "contactable_id"
    t.string "contactable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id"
  end

  create_table "corp_region_mappings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "corp_region_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corp_region_id"], name: "index_corp_region_mappings_on_corp_region_id"
    t.index ["country_id"], name: "index_corp_region_mappings_on_country_id"
  end

  create_table "corp_regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "corporate_id"
    t.string "region_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporate_id"], name: "index_corp_regions_on_corporate_id"
  end

  create_table "corp_vendor_regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "corp_region_id"
    t.bigint "corp_vendor_relation_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corp_region_id"], name: "index_corp_vendor_regions_on_corp_region_id"
    t.index ["corp_vendor_relation_id"], name: "index_corp_vendor_regions_on_corp_vendor_relation_id"
    t.index ["service_id"], name: "index_corp_vendor_regions_on_service_id"
  end

  create_table "corp_vendor_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "corporate_id"
    t.integer "vendor_id"
    t.string "owner_type"
    t.integer "is_primary"
    t.integer "is_pooled"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corp_vendor_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "corp_vendor_relation_id"
    t.bigint "vendor_service_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corp_vendor_relation_id"], name: "index_corp_vendor_services_on_corp_vendor_relation_id"
    t.index ["vendor_service_id"], name: "index_corp_vendor_services_on_vendor_service_id"
  end

  create_table "corporate_reservation_system_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "corp_vendor_relation_id"
    t.integer "vendor_reservation_system_relation_id"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vendor_approval"
    t.string "corporate_approval"
  end

  create_table "corporates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "display_name"
    t.string "registered_name"
    t.integer "contact"
    t.string "subdomain_name"
    t.integer "level"
    t.integer "country_id"
    t.string "gst_number"
    t.string "pan_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "iso_code"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_attribute_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "emp_attribute_id"
    t.integer "corporate_id"
    t.string "attribute_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "attribute_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "corp_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_api_calls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "call_id"
    t.integer "api_user_id"
    t.string "operation"
    t.string "status"
    t.string "status_code"
    t.string "status_message"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_login_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "reservation_system_id"
    t.string "login_type"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_region_mappings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "master_region_id"
    t.bigint "countries_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["countries_id"], name: "index_master_region_mappings_on_countries_id"
    t.index ["master_region_id"], name: "index_master_region_mappings_on_master_region_id"
  end

  create_table "master_regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "region_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paid_meals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slot_name"
    t.string "start_hrs"
    t.string "end_hrs"
    t.integer "tp_restrctn_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paid_seats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "travel_type"
    t.string "duration"
    t.integer "tp_restrctn_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferred_airlines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tp_restrctn_id"
    t.integer "service_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "corp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_system_srvc_prvdrs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "reservation_system_id"
    t.integer "service_provider_id"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_system_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_id"
  end

  create_table "reservation_systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "reservation_system_type_id"
    t.integer "service_id"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "service_providers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "service_id"
    t.string "name"
    t.string "code"
    t.string "regstrd_country_code"
    t.integer "reservation_system_id"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.string "logo_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.string "logo_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tp_al_cabin_classes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "class_name"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tp_exemptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tp_restrctn_id"
    t.string "exemptionable_type"
    t.bigint "exemptionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exemptionable_type", "exemptionable_id"], name: "index_tp_exemptions_on_exemptionable_type_and_exemptionable_id"
  end

  create_table "tp_policies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "policy_table_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "policy_name"
    t.integer "service_id"
  end

  create_table "tp_restrctns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tp_policy_id"
    t.integer "corporate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "emp_id"
    t.integer "corp_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_reservation_system_logins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vendor_reservation_system_relation_id"
    t.string "user_name"
    t.string "password"
    t.integer "master_login_type_id"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_num"
  end

  create_table "vendor_reservation_system_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vendor_id"
    t.integer "reservation_system_id"
    t.integer "service_provider_id"
    t.string "status"
    t.string "last_action"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendor_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vendor_id"
    t.integer "service_id"
    t.string "status"
    t.string "last_action"
    t.string "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "vendor_type"
    t.integer "country_id"
    t.string "status"
    t.string "pan_number"
    t.string "gst_number"
    t.string "iata_number"
    t.string "last_action"
    t.text "descr"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "corp_region_mappings", "corp_regions", on_delete: :cascade
  add_foreign_key "corp_region_mappings", "countries", on_delete: :cascade
  add_foreign_key "corp_regions", "corporates", on_delete: :cascade
  add_foreign_key "corp_vendor_regions", "corp_regions", on_delete: :cascade
  add_foreign_key "corp_vendor_regions", "corp_vendor_relations", on_delete: :cascade
  add_foreign_key "corp_vendor_regions", "services", on_delete: :cascade
  add_foreign_key "corp_vendor_services", "corp_vendor_relations", on_delete: :cascade
  add_foreign_key "corp_vendor_services", "vendor_services", on_delete: :cascade
  add_foreign_key "master_region_mappings", "countries", column: "countries_id", on_delete: :cascade
  add_foreign_key "master_region_mappings", "master_regions", on_delete: :cascade
end
