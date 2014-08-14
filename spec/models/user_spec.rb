require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
  end
  # 上記のbeforeは@userのデータを設定
  subject { @user }
  # subjectとして設定
  it { should respond_to(:name) } # :name要素が存在するはず
  it { should respond_to(:email) } # :email要素が存在するはず
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid } # validationが通れるはず

  describe "when name is not present" do
    before { @user.name = " " } # userの:name要素を空欄にする(データ投入)
    it { should_not be_valid } # そうしたらvalidation通れないはず
  end

  describe "when email is not present" do
    before { @user.email = " " } # 上と同じ
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before {@user.name = "a" * 51 } # :nameを51文字に設定
    it {should_not be_valid} # validation通れないはず
  end

# メールアドレスの格式を検査 (通れない例)
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org examply.user@foo.
                foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

# メールアドレスの格式を検査 (通れる例)
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
 # 登録時、メール重複しているかどうかチェック
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
# メールアドレスを小文字に変換することをテスト
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

 # 登録時、パスワードと確認パスワードは空欄かどうか確認
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", 
        password: " ", password_confirmation: " " )
    end
    it { should_not be_valid }
  end

 # 登録時、パスワードと確認パスワードは一致しているかどうか確認
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

# パスワードの長さを検証
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

 # ログイン時、メールアドレスとパスワードが一致しているかどうかを検証 
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user){ User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end