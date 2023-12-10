class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # 正規化を使用してパスワードを半角英数字6文字以上でformatを設定
  validates :password, length: { minimum: 6}, allow_blank: true, format: { with: /\A[a-zA-Z0-9]+\z/ }, confirmation: true

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  scope :related_to_question, ->(question) { joins(:answers).where(answers: { question_id: question.id }) }

  def mine?(object)
    object.user_id == id
  end

  private

  def validate_password_length
    # 正規化を使用してパスワードを半角英数字6文字以上で設定できてない場合にエラーメッセージ
    if passwaord.present? && !password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
    errors.add :password, 'は6桁以上で設定してください'
    end
  end

end
