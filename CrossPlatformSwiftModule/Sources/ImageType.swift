//
//  ImageType.swift
//  CrossPlatformSwiftModule
//
//  Created by tstone10 on 2020/3/22.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
typealias ImageType = UIImage
#elseif os(macOS)
import AppKit
typealias ImageType = NSImage
#endif
