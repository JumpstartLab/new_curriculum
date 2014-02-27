require 'spec_helper.rb'

describe User do
  def valid_attributes
    {
      provider:    "github",
      uid:         "123456",
      nickname:    "novohispano",
      name:        "Jorge Téllez",
      email:       "novohispano@example.com",
      oauth_token: "12345678",
      avatar_url:  "http://example.com/novohispano.jpg"
    }
  end

  def oauth
    {
      "provider"    => "github",
      "uid"         => "123456",
      "info"        => {
        "nickname" => "novohispano",
        "name"     => "Jorge Téllez",
        "email"    => "novohispano@gmail.com",
        "image"    => "http://example.com/novohispano.jpg"
      },
      "credentials" => {
        "token"    => "12345678"
      }
    }
  end

  context "when given the correct parameters" do
    it "creates a user" do
      result = User.create(valid_attributes)

      expect(result).to be_valid
      expect(result.provider).to eq "github"
      expect(result.uid).to eq "123456"
      expect(result.nickname).to eq "novohispano"
      expect(result.name).to eq "Jorge Téllez"
      expect(result.email).to eq "novohispano@example.com"
      expect(result.oauth_token).to eq "12345678"
      expect(result.avatar_url).to eq "http://example.com/novohispano.jpg"
    end

    it "creates a new user from omniauth" do
      result = User.from_omniauth(oauth)

      expect(result).to be_valid
    end

    it "finds a user when is already created" do
      user_1 = User.from_omniauth(oauth)
      user_2 = User.from_omniauth(oauth)

      expect(user_1.id).to eq user_2.id
    end

    it "updates the nickname of a user that already exists" do
      User.from_omniauth(oauth)
      modified_oauth = oauth
      modified_oauth["info"]["nickname"] = "kytrynyx"
      result = User.from_omniauth(modified_oauth)

      expect(result.nickname).to eq "kytrynyx"
    end

    it "updates the name of a user that already exists" do
      User.from_omniauth(oauth)
      modified_oauth = oauth
      modified_oauth["info"]["name"] = "Katrina"
      result = User.from_omniauth(modified_oauth)

      expect(result.name).to eq "Katrina"
    end

    it "updates the email of a user that already exists" do
      User.from_omniauth(oauth)
      modified_oauth = oauth
      modified_oauth["info"]["email"] = "kytrynyx@example.com"
      result = User.from_omniauth(modified_oauth)

      expect(result.email).to eq "kytrynyx@example.com"
    end

    it "updates the token of a user that already exists" do
      User.from_omniauth(oauth)
      modified_oauth = oauth
      modified_oauth["credentials"]["token"] = "987654321"
      result = User.from_omniauth(modified_oauth)

      expect(result.oauth_token).to eq "987654321"
    end

    it "updates the token of a user that already exists" do
      User.from_omniauth(oauth)
      modified_oauth = oauth
      modified_oauth["info"]["image"] = "http://example.com/kytrynyx.jpg"
      result = User.from_omniauth(modified_oauth)

      expect(result.avatar_url).to eq "http://example.com/kytrynyx.jpg"
    end
  end
end