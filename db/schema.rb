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

ActiveRecord::Schema[7.1].define(version: 2024_06_27_115101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_agencies_on_deleted_at"
  end

  create_table "agencies_programs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "agency_id"
    t.uuid "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id", "program_id"], name: "index_agencies_programs_on_agency_id_and_program_id", unique: true
  end

  create_table "agencies_zip_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "agency_id"
    t.uuid "zip_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id", "zip_code_id"], name: "index_agencies_zip_codes_on_agency_id_and_zip_code_id", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "careplans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "participant_id", null: false
    t.uuid "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["author_id"], name: "index_careplans_on_author_id"
    t.index ["deleted_at"], name: "index_careplans_on_deleted_at"
    t.index ["participant_id"], name: "index_careplans_on_participant_id", unique: true
  end

  create_table "case_management_agencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email_domain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_domain"], name: "index_case_management_agencies_on_email_domain", unique: true
  end

  create_table "incidents", force: :cascade do |t|
    t.date "date", default: -> { "CURRENT_DATE" }, null: false
    t.string "description", null: false
    t.uuid "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["participant_id"], name: "index_incidents_on_participant_id"
  end

  create_table "journal_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "author_id"
    t.uuid "caregiver_id", null: false
    t.date "date", default: -> { "CURRENT_DATE" }, null: false
    t.text "activities"
    t.text "health_changes"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "careplan_id", null: false
    t.string "missing_task_reason"
    t.datetime "deleted_at"
    t.index ["author_id"], name: "index_journal_entries_on_author_id"
    t.index ["caregiver_id", "date"], name: "index_journal_entries_on_caregiver_id_and_date", unique: true, where: "(deleted_at IS NULL)"
    t.index ["caregiver_id"], name: "index_journal_entries_on_caregiver_id"
    t.index ["careplan_id"], name: "index_journal_entries_on_careplan_id"
    t.index ["deleted_at"], name: "index_journal_entries_on_deleted_at"
  end

  create_table "participants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "phone_number", null: false
    t.string "medicaid_id", null: false
    t.integer "caregiver_relationship", default: 0, null: false
    t.uuid "case_management_agency_id", null: false
    t.uuid "zip_code_id", null: false
    t.uuid "caregiver_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "service_start_date", default: -> { "CURRENT_DATE" }
    t.index ["caregiver_id"], name: "index_participants_on_caregiver_id"
    t.index ["case_management_agency_id"], name: "index_participants_on_case_management_agency_id"
    t.index ["deleted_at"], name: "index_participants_on_deleted_at"
    t.index ["medicaid_id", "zip_code_id"], name: "index_participants_on_medicaid_id_and_zip_code_id", unique: true
    t.index ["zip_code_id"], name: "index_participants_on_zip_code_id"
  end

  create_table "programs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "is_medicaid", default: true, null: false
    t.string "name", null: false
    t.string "summary"
    t.string "description"
    t.string "url"
    t.string "givers_blog_url"
    t.string "givers_blog_id"
    t.integer "min_age", default: 0, null: false
    t.integer "max_age", default: 200, null: false
    t.string "state", null: false
    t.string "conditions", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_programs_on_deleted_at"
    t.index ["name", "state"], name: "index_programs_on_name_and_state", unique: true
  end

  create_table "survey_submissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "journal_entry_id"
    t.integer "survey_version", default: 1, null: false
    t.integer "confidence"
    t.integer "in_control"
    t.integer "stress"
    t.integer "energy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_survey_submissions_on_deleted_at"
    t.index ["journal_entry_id"], name: "index_survey_submissions_on_journal_entry_id", unique: true
  end

  create_table "task_submissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "journal_entry_id", null: false
    t.uuid "task_version_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_task_submissions_on_deleted_at"
    t.index ["journal_entry_id"], name: "index_task_submissions_on_journal_entry_id"
    t.index ["task_id"], name: "index_task_submissions_on_task_id"
  end

  create_table "task_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "emoji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_task_templates_on_name", unique: true
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "emoji"
    t.uuid "task_template_id", null: false
    t.string "cron_schedule"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", default: "as_needed", null: false
    t.uuid "careplan_id"
    t.index ["careplan_id"], name: "index_tasks_on_careplan_id"
    t.index ["task_template_id"], name: "index_tasks_on_task_template_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "zoho_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "caring_for"
    t.uuid "zip_code_id"
    t.string "checkr_worker_id"
    t.string "ed_app_id"
    t.jsonb "metadata", default: {}
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(email IS NOT NULL)"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true, where: "(phone_number IS NOT NULL)"
    t.index ["zip_code_id"], name: "index_users_on_zip_code_id"
  end

  create_table "versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "item_type", null: false
    t.string "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zip_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "zip", null: false
    t.string "state", null: false
    t.string "counties", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zip"], name: "index_zip_codes_on_zip"
  end

  add_foreign_key "careplans", "participants"
  add_foreign_key "careplans", "users", column: "author_id"
  add_foreign_key "incidents", "participants"
  add_foreign_key "journal_entries", "careplans"
  add_foreign_key "journal_entries", "users", column: "author_id"
  add_foreign_key "journal_entries", "users", column: "caregiver_id"
  add_foreign_key "participants", "case_management_agencies"
  add_foreign_key "participants", "users", column: "caregiver_id"
  add_foreign_key "participants", "zip_codes"
  add_foreign_key "survey_submissions", "journal_entries"
  add_foreign_key "task_submissions", "journal_entries"
  add_foreign_key "task_submissions", "tasks"
  add_foreign_key "task_submissions", "versions", column: "task_version_id"
  add_foreign_key "tasks", "careplans"
  add_foreign_key "tasks", "task_templates"
  add_foreign_key "users", "zip_codes"
end
