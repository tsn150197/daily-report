class ChangeDefaultStatusInReports < ActiveRecord::Migration[5.2]
  def change
    change_column :reports, :status, default: 0
  end
end
