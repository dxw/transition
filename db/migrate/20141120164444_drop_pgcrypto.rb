class DropPgcrypto < ActiveRecord::Migration[6.0]
  def up
#    disable_extension 'pgcrypto'
  end

  def down
#    enable_extension 'pgcrypto'
  end
end
