class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :ensure_has_a_name

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable

  enum role: %i[customer admin]

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /.+@.+\.{1}.{2,}/ }

  validates :password, length: { in: 6..128 }, if: lambda { self.password.present? }
  validates_confirmation_of :password, if: lambda { self.password.present? }

  private

  def ensure_has_a_name
    return if self.email.blank?

    self.name = "#{self.email[/^[^@]+/].humanize.gsub(/[^a-zA-Z]/, "")}" if name.blank?
  end
end
