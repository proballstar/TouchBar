//
//  ToolbarSlider.swift
//  TouchBar
//
//  Created by Aaron Ma on 5/22/19.
//  Copyright © 2019 Firebolt, Inc. All rights reserved.
//

import Foundation
import Defaults

private final class ToolbarSliderCell: NSSliderCell {
    var fillColor: NSColor
    var borderColor: NSColor
    var shadow: NSShadow?
    
    init(fillColor: NSColor, borderColor: NSColor, shadow: NSShadow? = nil) {
        self.fillColor = fillColor
        self.borderColor = borderColor
        self.shadow = shadow
        super.init()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawKnob(_ knobRect: CGRect) {
        var frame = knobRect.insetBy(dx: 0, dy: 6.5)
        if let shadow = self.shadow {
            frame.origin.x *= ((barRect.width - shadow.shadowBlurRadius * 2) / barRect.width)
            frame.origin.x += shadow.shadowBlurRadius
        }
        
        NSGraphicsContext.saveGraphicsState()
        
        shadow?.set()
        
        let path = NSBezierPath(roundedRect: frame, xRadius: 4, yRadius: 12)
        fillColor.set()
        path.fill()
        
        NSShadow().set()
        

        borderColor.set()
        path.lineWidth = 0.8
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    private var barRect = CGRect.zero
    
    override func drawBar(inside rect: CGRect, flipped: Bool) {
        barRect = rect
 
        if let shadow = self.shadow {
            barRect = barRect.insetBy(dx: shadow.shadowBlurRadius * 2, dy: 0)
        }
        
        super.drawBar(inside: barRect, flipped: flipped)
    }
}

extension NSSlider {
    func alwaysRedisplayOnValueChanged() -> Self {
        addAction { sender in
            if (defaults[.windowTransparency] - sender.doubleValue) != 0 {
                sender.needsDisplay = true
            }
        }
        
        return self
    }
}

final class ToolbarSlider: NSSlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let knobShadow = NSShadow()
        knobShadow.shadowColor = NSColor.black.withAlphaComponent(0.7)
        knobShadow.shadowOffset = CGSize(width: 0.8, height: -0.8)
        knobShadow.shadowBlurRadius = 5
        
        self.cell = ToolbarSliderCell(fillColor: .lightGray, borderColor: .black, shadow: knobShadow)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class MenubarSlider: NSSlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let knobShadow = NSShadow()
        knobShadow.shadowColor = NSColor.black.withAlphaComponent(0.6)
        knobShadow.shadowOffset = CGSize(width: 0.8, height: -0.8)
        knobShadow.shadowBlurRadius = 4
        
        self.cell = ToolbarSliderCell(fillColor: .controlTextColor, borderColor: .clear, shadow: knobShadow)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
