class CreateTwitterUsers < ActiveRecord::Migration
  def change
  	create_table :twitter_users do |t|
  		t.string :username
  		t.string :token
  		t.string :secret
  		t.timestamps null:false
  	end
  end
end
