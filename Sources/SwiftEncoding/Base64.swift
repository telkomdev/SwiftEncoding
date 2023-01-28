import Foundation

public enum Base64Error: Error {
    case invalidBase64Char
}

public func encodeBase64(data: Data) -> String { encodeBase64(data: data.bytes) }

public func encodeBase64(data: String) -> String { encodeBase64(data: data.asByteArray()) }

public func encodeBase64(data: [UInt8]) -> String {
    let base64Table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

    var encoded: String = ""

    let count = data.count
    let paddingCount = data.count%3 > 0 ? 3 - (data.count%3) : 0

    var begin = 0
    var end = 3
    while true {
        var segments: [UInt8] = []

        if begin >= count { break }

        if end > count {
            segments = Array(data[begin...])
        } else {
            segments = Array(data[begin..<end])
        }

        var segmentSum = 0
        for i in 0..<segments.count {
            let shift = 16 - (i * 8)
            segmentSum |= Int(segments[i]) << shift
            
        }

        for i in 0...segments.count {
            let shift = 18 - (i * 6)
            let b = (segmentSum >> shift) & 0x3F
            let c = base64Table[base64Table.index(base64Table.startIndex, offsetBy: b)]
            encoded.append(c)
        }

        begin += 3
        end += 3
    }

    // add padding
    for _ in 0..<paddingCount {
        let c = "="
        encoded.append(c)
    }

    return encoded
}

public func decodeBase64(data: String) throws -> String { try decodeBase64(data: data.asByteArray()) }

public func decodeBase64(data: [UInt8]) throws -> String {
    let base64TableDict: [Int: Int] = [0x41: 0, 0x42: 1, 0x43: 2, 0x44: 3, 
        0x45: 4, 0x46: 5, 0x47: 6, 0x48: 7, 
        0x49: 8, 0x4A: 9, 0x4B: 10, 0x4C: 11, 
        0x4D: 12, 0x4E: 13, 0x4F: 14, 0x50: 15, 
        0x51: 16, 0x52: 17, 0x53: 18, 0x54: 19, 
        0x55: 20, 0x56: 21, 0x57: 22, 0x58: 23, 
        0x59: 24, 0x5A: 25, 0x61: 26, 0x62: 27, 
        0x63: 28, 0x64: 29, 0x65: 30, 0x66: 31, 
        0x67: 32, 0x68: 33, 0x69: 34, 0x6A: 35, 
        0x6B: 36, 0x6C: 37, 0x6D: 38, 0x6E: 39, 
        0x6F: 40, 0x70: 41, 0x71: 42, 0x72: 43, 
        0x73: 44, 0x74: 45, 0x75: 46, 0x76: 47, 
        0x77: 48, 0x78: 49, 0x79: 50, 0x7A: 51, 
        0x30: 52, 0x31: 53, 0x32: 54, 0x33: 55, 
        0x34: 56, 0x35: 57, 0x36: 58, 0x37: 59, 
        0x38: 60, 0x39: 61, 0x2B: 62, 0x2F: 63]
    
    
    var decoded: [UInt8] = []
    var count = data.count

    let lastSegment = data[(count-4)...]
    let slicePaddIfAnyIndex = lastSegment.firstIndex(of: 0x3D) ?? data.endIndex

    // assign new data
    let newdata = Array(data[data.startIndex..<slicePaddIfAnyIndex])

    // re assign count with newdata.count
    count = newdata.count
    
    var begin = 0
    var end = 4

    while true {
        var segments: [UInt8] = []

        if begin >= count { break }

        if end > count {
            segments = Array(newdata[begin...])
        } else {
            segments = Array(newdata[begin..<end])
        }

        var segmentSum = 0
        for i in 0..<segments.count {
            if base64TableDict[Int(segments[i])] == nil {
                throw Base64Error.invalidBase64Char
            }

            let base64Idx = base64TableDict[Int(segments[i])]!
            let shift = 18 - (i * 6)
            segmentSum |= base64Idx << shift
            
        }

        for i in 0..<segments.count-1 {
            let shift = 16 - (i * 8)
            let b = (segmentSum >> shift) & 0xFF
            if b == 0x0 { continue }
            decoded.append(UInt8(b))
        }

        begin += 4
        end += 4
    }

    return String(decoding: decoded, as: UTF8.self)
}