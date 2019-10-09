defmodule IvRomance.Admin.Auth.TokenTest do
  use IvRomance.DataCase, async: true

  alias Ecto.UUID
  alias IvRomance.Admin.Auth.Token

  describe "sign/1, verify/1" do
    test "encodes and decodes values" do
      user_id = UUID.generate()
      token = Token.sign(user_id)
      assert {:ok, ^user_id} = Token.verify(token)
    end
  end
end
