class CreateGitApis < ActiveRecord::Migration
  def change
    create_table :git_apis do |t|
      t.string :clone_url
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
