class Room < ApplicationRecord
  # association

  # validation
  VALID_CODE_REGEX = /\A[\w-]+\z/ # a-z A-Z 0-9 _ -
  validates :code,
    presence: true,
    uniqueness: true,
    length: { in: 1..255 },
    format: { with: VALID_CODE_REGEX}
  validates :name,
    length: { maximum: 255 }

  # クラスメソッド

  # a-zA-Z0-9_-から成る8文字の文字列を返す
  def self.random_code
    SecureRandom.urlsafe_base64(nil, false)[0..7]
  end


  # インスタンスメソッド

  # codeのみについて有効かどうかをbooleanで返す
  def has_valid_code?
    self.errors.clear
    self.valid?
    result = self.errors.messages[:code].count.zero?
    self.errors.clear
    return result
  end

end
