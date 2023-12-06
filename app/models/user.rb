class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, presence: true, if: -> { password.present? }




  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  scope :related_to_question, ->(question) { joins(:answers).where(answers: { question_id: question.id }) }

  def mine?(object)
    object.user_id == id
  end

end
