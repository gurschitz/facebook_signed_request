defmodule FacebookSignedRequestTest do
  use ExUnit.Case, async: true
  doctest FacebookSignedRequest
  
  @secret "897z956a2z7zzzzz5783z458zz3z7556"
  @valid_request "53umfudisP7mKhsi9nZboBg15yMZKhfQAARL9UoZtSE.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMDg5ODg4MDAsImlzc3VlZF9hdCI6MTMwODk4NTAxOCwib2F1dGhfdG9rZW4iOiIxMTExMTExMTExMTExMTF8Mi5BUUJBdHRSbExWbndxTlBaLjM2MDAuMTExMTExMTExMS4xLTExMTExMTExMTExMTExMXxUNDl3M0Jxb1pVZWd5cHJ1NTFHcmE3MGhFRDgiLCJ1c2VyIjp7ImNvdW50cnkiOiJkZSIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMTExMTExMTExMTExMSJ9"
  @invalid_request "umfudisP7mKhsi9nZboBg15yMZKhfQAARL9UoZtSE.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMDg5ODg4MDAsImlzc3VlZF9hdCI6MTMwODk4NTAxOCwib2F1dGhfdG9rZW4iOiIxMTExMTExMTExMTExMTF8Mi5BUUJBdHRSbExWbndxTlBaLjM2MDAuMTExMTExMTExMS4xLTExMTExMTExMTExMTExMXxUNDl3M0Jxb1pVZWd5cHJ1NTFHcmE3MGhFRDgiLCJ1c2VyIjp7ImNvdW50cnkiOiJkZSIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMTExMTExMTExMTExMSJ9"

  describe "valid?" do
  	test "returns true for valid request" do
	    assert FacebookSignedRequest.valid?(@valid_request, @secret) == true
	  end

	  test "returns false for invalid request" do
	    assert FacebookSignedRequest.valid?(@invalid_request, @secret) == false
	  end

	  test "returns error when secret is nil" do
	  	assert {:error, _} = FacebookSignedRequest.valid?(@valid_request)
	  end

	  test "returns true when secret is set in env variable" do
	   	System.put_env("FACEBOOK_SIGNED_REQUEST_APP_SECRET", @secret)
	  	assert FacebookSignedRequest.valid?(@valid_request) == true
	   	System.delete_env("FACEBOOK_SIGNED_REQUEST_APP_SECRET")
	  end
  end

	describe "data" do
 		@expected_data %{
				"algorithm" => "HMAC-SHA256", 
				"expires" => 1308988800,
		  "issued_at" => 1308985018,
		  "oauth_token" => "111111111111111|2.AQBAttRlLVnwqNPZ.3600.1111111111.1-111111111111111|T49w3BqoZUegypru51Gra70hED8",
		  "user" => %{
		  	"age" => %{"min" => 21}, 
		  	"country" => "de", 
		  	"locale" => "en_US"
	  	},
		  "user_id" => "111111111111111"
		}

 		test "returns the expected data" do
	    assert Map.equal?(FacebookSignedRequest.data(@valid_request, @secret), @expected_data)
	  end

	  test "returns false for invalid request" do
	    assert {:error, _} = FacebookSignedRequest.data(@invalid_request, @secret)
	  end

	  test "returns error when secret is nil" do
	  	assert {:error, _} = FacebookSignedRequest.data(@valid_request)
	  end

	  test "returns true when secret is set in env variable" do
		  System.put_env("FACEBOOK_SIGNED_REQUEST_APP_SECRET", @secret)
	  	assert Map.equal?(FacebookSignedRequest.data(@valid_request), @expected_data)
	   	System.delete_env("FACEBOOK_SIGNED_REQUEST_APP_SECRET")
	  end
 	end
end
