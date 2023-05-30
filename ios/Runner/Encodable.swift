extension Encodable {
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        do {
            let data = try encoder.encode(self)
            let object = try JSONSerialization.jsonObject(with: data)
            guard let json = object as? [String: Any] else {
                print("Deserialized object is not a dictionary")
                return [:]
            }
            return json
        } catch {
            return [:]
        }
    }}
