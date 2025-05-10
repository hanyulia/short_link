import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";

actor {
  type ShortLink = {
    shortCode : Text;
    fullURL : Text;
  };

  stable var counter : Nat = 0;
  stable var links : HashMap.HashMap<Text, Text> = HashMap.HashMap(0, Text.equal, Text.hash);

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
    var list : [ShortLink] = [];
    for ((code, url) in links.entries()) {
      list := list # [{ shortCode = code; fullURL = url }];
    };
    return list;
  };
};
