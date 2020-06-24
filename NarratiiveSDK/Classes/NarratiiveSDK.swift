import AdSupport

public final class NarratiiveSDK {
    static let NarratiiveSDKToken = "NarratiiveSDKToken"
    
    
    var host: String?
    var hostKey: String?
    var idfa: String?
    var token: String?
    public var debug: Bool = false
    
    private func log(_ msg: String) {
        if debug {
            print(msg)
        }
    }
 
    private func loadIDFA() {
        log("Loading IDFA from device...")
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            log("\t- IDFA loaded: \(String(describing: idfa))")
        } else {
            idfa = nil
            log("\t- IDFA NOT loaded")
        }
    }
    
    private func loadToken() {
        log("Loading token from UserDefault...")
        token = UserDefaults.standard.string(forKey: NarratiiveSDK.NarratiiveSDKToken)
        
        if let token = token {
            log("\t- token loaded: \(token)")
        } else {
            log("\t- token NOT loaded.")
        }
    }
    
    private func postJson(jsonDict: [String: String?], urlString: String, completion: @escaping ([String: Any]?, Error?, Bool?) -> Void) {
        log("Making a POST request to \(urlString)...")
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
                
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
                
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: [])
            
            log("\t- with data \( String(decoding: jsonData, as: UTF8.self))...")
            
            URLSession.shared.uploadTask(with: request, from: jsonData) {
                data, response, error in
                
                var success = false
                if let httpResponse = response as? HTTPURLResponse {
                    success = httpResponse.statusCode == 200 || httpResponse.statusCode == 202
                }
                
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(json, error, success)
                } else {
                    completion(nil, error, success)
                }
                
                
            }.resume()
            
        } catch let error {
            log("\t- POST request failed with error: \(error)...")
            completion(nil, error, false)
        }
    }
    
    private func createToken(completion: @escaping () -> Void) {
        log("Creating a new Token...")
        guard host != nil, hostKey != nil else {
            log("\t- Missing host or hostKey, abort.")
            return
        }
        
        let json = [
            "host": host,
            "hostKey": hostKey,
            "idfa": idfa
        ]
                
        postJson(jsonDict: json, urlString: "https://collector.effectivemeasure.net/app/tokens") {
            data, error, success in
            
            if let data = data, let success = success {
                if success && data["token"] != nil {
                    let newToken = data["token"] as? String
                    self.token = newToken
                    self.log("\t- Token created: \(String(describing: newToken))")
                    self.saveToken()
                    completion()
                }
            }
        }
    }
    
    private func saveToken() {
        log("Saving token to UserDefault")
        if let token = token {
            log("\t- Token saved: \(token)")
            UserDefaults.standard.set(token, forKey: NarratiiveSDK.NarratiiveSDKToken)
        } else {
            log("\t- Error: token is missing")
        }
    }
    
    private func registerHit(path: String?) {
        log("Sending screen event with '\(path ?? "")'.")
        
        guard token != nil, host != nil, hostKey != nil else {
            return
        }
        
        let json = [
            "host": host,
            "hostKey": hostKey,
            "token": token,
            "path": path
        ]
        
        postJson(jsonDict: json, urlString: "https://collector.effectivemeasure.net/app/hits") {
            data, error, success in
            
            if let data = data, let success = success {
                if success && data["token"] != nil {
                    self.token = data["token"] as? String
                    self.log("\t- Request succeeded. New token received: \(self.token!)")
                    self.saveToken()
                }
            }
        }
    }
      
    private init() {
    }
    
    private static var sharedNarratiiveSDK: NarratiiveSDK = {
        let sdk = NarratiiveSDK()
        // More config here if required
        
        return sdk
    }()
    
    public class func sharedInstance() -> NarratiiveSDK? {
        return sharedNarratiiveSDK
    }
    
    public func setup(withHost: String, andHostKey: String) {
        log("Setting up instance with \(withHost) and \(andHostKey).")
        
        host = withHost
        hostKey = andHostKey
        
        loadIDFA()
        loadToken()
    }
    
    public func send(screenName: String) {
        
        
        if token != nil {
            registerHit(path: screenName)
        } else {
            createToken {
                self.registerHit(path: screenName)
            }
        }
    }
}