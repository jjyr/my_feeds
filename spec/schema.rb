ActiveRecord::Schema.define(:version => 0) do

  create_table "feeds", :force => true do |t|
    t.integer  "source_id",       :null => false
    t.string   "source_type",     :null => false
    t.string   "source_identity", :null => false
    t.string   "event",           :null => false
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "feeds", ["source_identity"], :name => "index_feeds_on_source_identity"

  create_table "likes", :force => true do |t|
    t.string   "likeable_identity", :null => false
    t.integer  "likeable_id",       :null => false
    t.string   "likeable_type",     :null => false
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
