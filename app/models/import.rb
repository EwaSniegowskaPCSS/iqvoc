class Import < ApplicationRecord
  belongs_to :user
  mount_uploader :import_file, RdfUploader
  validates_presence_of :import_file, :default_namespace

  def finish!(messages)
    self.output = messages
    self.success = true
    self.finished_at = Time.now
    save!
  end

  def fail!(exception)
    self.output = exception.to_s + "\n\n" + exception.backtrace.join("\n")
    self.finished_at = Time.now
    save!
  end
end
