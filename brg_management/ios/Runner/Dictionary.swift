extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: .utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    /// Append dictionary to dictionary.
    mutating func append (_ dict: Dictionary) {
        dict.forEach{
            self.updateValue($1, forKey: $0)
        }
    }
}
