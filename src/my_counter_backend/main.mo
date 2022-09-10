import Text "mo:base/Text";
import Int "mo:base/Int"

actor Counter {

  type HttpRequest = {
    body : Blob;
    headers : [HeaderField];
    method : Text;
    url : Text;
  };
  type HttpResponse = {
    body : Blob;
    headers : [HeaderField];
    status_code : Nat16;
  };
  type HeaderField = (Text, Text);

  stable var counter = 0;
  public query func get() : async Nat {
    return counter;
  };

  public func set(n : Nat) : async () {
    counter := n;
  };

  public func inc() : async () {
    counter += 1;
  };

  public query func http_request(arg : HttpRequest) : async HttpResponse {
    {
      body = Text.encodeUtf8("<html><body>Counter is " # Int.toText(counter) # "</body></html>");
      headers = [("ContentType", "text/html")];
      status_code = 200;
    };
  };
};
