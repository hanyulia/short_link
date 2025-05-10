import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";

actor {
  type ShortLink = {
    shortCode : Text;
    fullURL : Text;
  };

  stable var counter : Nat = 0;

  var links : HashMap.HashMap<Text, Text> = HashMap.HashMap(0, Text.equal, Text.hash);

  public func createShortLink(fullURL : Text) : async Text {
    let shortCode = "icp" # Nat.toText(counter);
    links.put(shortCode, fullURL);
    counter += 1;
    return shortCode;
  };

  public query func getFullURL(code : Text) : async ?Text {
    return links.get(code);
  };

  public query func getAllLinks() : async [ShortLink] {
    let buffer = Buffer.Buffer<ShortLink>(0);
    for ((code, url) in links.entries()) {
      buffer.add({ shortCode = code; fullURL = url });
    };
    return Buffer.toArray(buffer);
  };
};
