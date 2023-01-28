import Foundation

public extension String {
    func asByteArray() -> [UInt8] {
        return self.utf8.map{UInt8($0)}
    }

    var byteArray : [UInt8] {
        return self.utf8.map{UInt8($0)}
    }
}

extension Data {
    var bytes: [UInt8] {
        return [UInt8] (self)
    }
}

extension Array where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
}