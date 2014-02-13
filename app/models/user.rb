class User < ActiveRecord::Base
  def self.from_omniauth(oauth)
    user = User.find_or_create_by(
      provider:    oauth["provider"],
      uid:         oauth["uid"],
      )

    user.update_attributes(
      nickname:    oauth["info"]["nickname"],
      name:        oauth["info"]["name"],
      email:       oauth["info"]["email"],
      oauth_token: oauth["credentials"]["token"],
      avatar_url:  oauth["info"]["image"]
    )

    user
  end
end