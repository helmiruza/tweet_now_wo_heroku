class CreateTwitterUsers < ActiveRecord::Migration
  def change
  	create_table :twitter_users do |t|
  		t.string :username
  		t.timestamps null:false
  	end
  end
end
