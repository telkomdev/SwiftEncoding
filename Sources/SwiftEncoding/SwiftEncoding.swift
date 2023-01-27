public extension String {
    func asByteArray() -> [UInt8] {
        return self.utf8.map{UInt8($0)}
    }

    var byteArray : [UInt8] {
        return self.utf8.map{UInt8($0)}
    }
}