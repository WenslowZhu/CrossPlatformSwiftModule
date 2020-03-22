//
//  CurrentOS.swift
//  CrossPlatformSwiftModule
//
//  Created by tstone10 on 2020/3/22.
//

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(tvOS)
import TVUIKit
#elseif os(macOS)
import AppKit
#endif

func currentOS() -> String {
    #if os(iOS)
    return "iOS"
    #elseif os(watchOS)
    return "WatchKit"
    #elseif os(tvOS)
    return "TVUIKit"
    #elseif os(macOS)
    return "AppKit"
    #endif
}
