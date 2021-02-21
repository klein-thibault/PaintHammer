//
//  PHImage.swift
//  
//
//  Created by Thibault Klein on 2/21/21.
//

import SwiftUI

#if os(iOS)
    import UIKit
    public typealias PHImage = UIImage
#elseif os(OSX)
    import AppKit
    public typealias PHImage = NSImage
#endif
