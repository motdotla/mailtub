class RawEmail < ActiveRecord::Base
  validates :redis_key, presence: true, uniqueness: true
  validates :source, presence: true
end
