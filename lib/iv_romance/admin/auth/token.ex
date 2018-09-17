defmodule IvRomance.Admin.Auth.Token do
  @secret Application.get_env(:iv_romance, __MODULE__)[:secret]
  @salt Application.get_env(:iv_romance, __MODULE__)[:salt]
  @max_age 86400

  def sign(user_id), do: Phoenix.Token.sign(@secret, @salt, user_id)

  def verify(token), do: Phoenix.Token.verify(@secret, @salt, token, max_age: @max_age)
end
