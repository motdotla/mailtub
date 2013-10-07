class RawEmail < ActiveRecord::Base
  validates :redis_key, presence: true, uniqueness: true
  validates :source,    presence: true

  before_save :set_microtime

  private

  def set_microtime
    parts           = redis_key.split("|")
    self.microtime  = parts[0].to_i if parts
  end
end
