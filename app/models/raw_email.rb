class RawEmail < ActiveRecord::Base
  validates :redis_key, presence: true, uniqueness: true
  validates :source,    presence: true

  before_save :set_microtime

  def self.sync! do
    redis = Redis.new(:host => REDIS_HOST)
    keys  = redis.keys
    keys.each do |key|
      source = redis.get key
      self.create(redis_key: key, source: source)
    end
  end

  private

  def set_microtime
    parts           = redis_key.split("|")
    self.microtime  = parts[0].to_i if parts
  end
end
