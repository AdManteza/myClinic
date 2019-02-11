class PasswordStrategy
  def self.random
    SecureRandom.hex(3)
  end
end
