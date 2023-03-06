class CreateMoviesTags < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_tags do |t|
      t.belongs_to :movie
      t.belongs_to :tag

      t.timestamps
    end
  end
end
