import Foundation

public enum HexError: Error {
    case invalidHexChar
}

public func encodeHex(data: Data) -> String { encodeHex(data: data.bytes) }

public func encodeHex(data: String) -> String { encodeHex(data: data.asByteArray()) }

public func encodeHex(data: [UInt8]) -> String {
    let hexTable = "0123456789abcdef"
    
    func hex(d: UInt8) -> String {
        let segmentA = d >> 0x4
        let segmentB = d & 0xF

        var encoded = ""
        encoded.append(hexTable[hexTable.index(hexTable.startIndex, offsetBy: Int(segmentA))])
        encoded.append(hexTable[hexTable.index(hexTable.startIndex, offsetBy: Int(segmentB))])
        return encoded
    }

    return data.map{hex(d: $0)}.joined()
}

public func decodeHex(data: String) throws-> String { try decodeHex(data: data.asByteArray()) }

public func decodeHex(data: [UInt8]) throws -> String {
    let hexDict: [UInt8 : UInt8] = [48: 0, 49: 1, 50: 2, 51: 3, 
        52: 4, 53: 5, 54: 6, 55: 7, 
        56: 8, 57: 9, 97: 10, 98: 11, 
        99: 12, 100: 13, 101: 14, 102: 15, 
        65: 10, 66: 11, 67: 12, 68: 13, 
        69: 14, 70: 15]

    var buffer: [UInt8] = []
    for i in 0..<(data.count/2) {
        let indexA = i * 2
        let indexB = i * 2 + 1

        let keyA = data[indexA]
        let keyB = data[indexB]

        let segmentA = hexDict[keyA]
        let segmentB = hexDict[keyB]

        if segmentA == nil || segmentB == nil {
            throw HexError.invalidHexChar
        }

        let buf = (segmentA! << 0x4) | segmentB!

        buffer.append(buf)

    }

    return String(decoding: buffer, as: UTF8.self)
}