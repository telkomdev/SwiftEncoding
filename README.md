## SwiftEncoding

Text Encoding for Swift

[![SwiftEncoding](https://github.com/telkomdev/SwiftEncoding/actions/workflows/ci.yml/badge.svg)](https://github.com/telkomdev/SwiftEncoding/actions/workflows/ci.yml)


### Current features
- Base64 encoding
- Hex encoding

### Usage

Import `SwiftEncoding` to your `Package.swift` as a dependency

```swift
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/telkomdev/SwiftEncoding.git", from: "1.0.1"),
    ],
    targets: [
        .executableTarget(
            name: "MyApp",
            dependencies: [
                .byName(name: "SwiftEncoding")
            ]),
        .testTarget(
            name: "MyAppTests",
            dependencies: ["MyApp"]),
    ]
)
```

Encode text with `Base64`
```swift
import SwiftEncoding

@main
public struct App {

    public static func main() {
        let base64EncodeRes = encodeBase64(data: "swift is cool")
        print(base64EncodeRes)

        do {
            let base64DecodeRes = try decodeBase64(data: base64EncodeRes)
            print(base64DecodeRes)
        } catch {
            print("base64 decode error")
        }
    }
}
```

Encode text with `Hex`
```swift
import SwiftEncoding

@main
public struct App {

    public static func main() {
        let hexEncodeRes = encodeHex(data: "swift is cool")
        print(hexEncodeRes)

        do {
            let hexDecodeRes = try decodeHex(data: hexEncodeRes)
            print(hexDecodeRes)
        } catch {
            print("hex decode error")
        }
    }
}
```

Encode raw binary data with `Base64`
```swift
import SwiftEncoding
import Foundation;

@main
public struct App {

    public static func main() {
        let fileManager = FileManager.default

        print(fileManager.currentDirectoryPath)
        
        if let fileData = fileManager.contents(atPath: "\(fileManager.currentDirectoryPath)/../burger.png") {
            let hexEncodeRes = encodeBase64(data: fileData)
            print(hexEncodeRes)
        } else {
            print("error reading file")
        }
    }
}
```

Encode raw binary data with `Hex`
```swift
import SwiftEncoding
import Foundation;

@main
public struct App {

    public static func main() {
        let fileManager = FileManager.default

        print(fileManager.currentDirectoryPath)
        
        if let fileData = fileManager.contents(atPath: "\(fileManager.currentDirectoryPath)/../burger.png") {
            let hexEncodeRes = encodeHex(data: fileData)
            print(hexEncodeRes)
        } else {
            print("error reading file")
        }
    }
}
```