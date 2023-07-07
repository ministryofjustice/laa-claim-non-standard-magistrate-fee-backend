class AddEvidenceUpload < ActiveRecord::Migration[7.0]
  def change
    create_table :evidence_uploads, id: :uuid do |t|
      t.references :claim, null: false, foreign_key: true, type: :uuid
      t.date :upload_date
      t.string :upload_name
      t.integer :file_size

      t.timestamps
    end

    add_column :claims, :evidence_uploads, :uuid
  end
end
