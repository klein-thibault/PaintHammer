//
//  PHColor.swift
//  
//
//  Created by Thibault Klein on 2/21/21.
//

import SwiftUI

#if os(iOS)
    import UIKit
    public typealias PHColor = UIColor
#elseif os(OSX)
    import AppKit
    public typealias PHColor = NSColor
#endif
