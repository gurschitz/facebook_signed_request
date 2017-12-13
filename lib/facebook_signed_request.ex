defmodule FacebookSignedRequest do
  @moduledoc """
  This module provides methods for checking the validity of a signed request 
  and extracting the data out of it. 
  """

  @doc """
  Checks if the signed request is valid or not.
  """
  def valid?(signed_request, app_secret \\ get_app_secret()) do
    {signature, payload} = split_signed_request(signed_request)
    check_signature(signature, payload, app_secret)
  end

  @doc """
  Extracts the data of the signed request.
  """
  def data(signed_request, app_secret \\ get_app_secret()) do
    {signature, payload} = split_signed_request(signed_request)

    case check_signature(signature, payload, app_secret) do
      true -> payload |> Base.decode64!(padding: false) |> Poison.decode!
      false -> {:error, "Signed Request is invalid!"}
      other -> other
    end
  end

  defp check_signature(signature, payload, app_secret) do
    case app_secret do
      nil -> {:error, "You need to pass or set an app secret!"}
      _ -> check_signature!(signature, payload, app_secret)
    end
  end

  defp check_signature!(signature, payload, app_secret) do
    signature = signature |> prepare_base64_url
    case sha256_hmac(payload, app_secret) do
      ^signature ->
        true
      _ ->
        false
    end
  end

  defp split_signed_request(signed_request) do
    [signature | [payload | []]] = signed_request |> String.split(".")

    {signature, payload}
  end

  defp sha256_hmac(payload, app_secret) do
    :crypto.hmac(:sha256, app_secret, payload)
    |> Base.encode64
    |> String.strip
  end

  defp prepare_base64_url(str) do
    mode = str |> String.length |> rem(4)
    equal_signs = "=" |> String.duplicate(4 - mode)
    str <> equal_signs 
    |> String.replace("-","+")
    |> String.replace("_","/")
  end

  defp get_app_secret, do: System.get_env("FACEBOOK_SIGNED_REQUEST_APP_SECRET")
end
