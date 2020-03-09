class ApiClient < ApplicationRecord
  validates :name, uniqueness: true

  def generate_token
    api_key = SecureRandom.hex
    update(key: Digest::SHA512.hexdigest(api_key))

    api_key
  end
end
