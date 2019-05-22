//
//  Constants.swift
//  TouchBar
//
//  Created by Aaron Ma on 5/22/19.
//  Copyright © 2019 Firebolt, Inc. All rights reserved.
//

import Foundation
import Defaults

struct Constants {
    static let windowAutosaveName = "TouchBar"
}

extension Defaults.Keys {
    static let windowTransparency = Key<Double>("windowTransparency", default: 0.75)
    static let windowDocking = Key<TouchBarWindow.Docking>("windowDocking", default: .floating)
    static let showOnAllDesktops = Key<Bool>("showOnAllDesktops", default: false)
    static let lastFloatingPosition = OptionalKey<CGPoint>("lastFloatingPosition")
}
