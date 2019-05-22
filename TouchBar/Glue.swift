//
//  Glue.swift
//  TouchBar
//
//  Created by Aaron Ma on 5/22/19.
//  Copyright © 2019 Firebolt, Inc. All rights reserved.
//

import Foundation
import Defaults

extension Defaults {
    @discardableResult
    func observe<T: Codable, Weak: AnyObject>(
        _ key: Key<T>,
        tiedToLifetimeOf weaklyHeldObject: Weak,
        options: NSKeyValueObservingOptions = [.initial, .new, .old],
        handler: @escaping (KeyChange<T>) -> Void
        ) -> DefaultsObservation {
        var observation: DefaultsObservation!
        observation = observe(key, options: options) { [weak weaklyHeldObject] change in
            guard let temporaryStrongReference = weaklyHeldObject else {
                observation.invalidate()
                return
            }
            
            _ = temporaryStrongReference
            handler(change)
        }
        
        return observation
    }
}

extension NSMenuItem {
    func bindState(to key: Defaults.Key<Bool>) -> Self {
        addAction { _ in
            defaults[key].toggle()
        }
        
        defaults.observe(key, tiedToLifetimeOf: self) { [unowned self] change in
            self.isChecked = change.newValue
        }
        
        return self
    }
    
    func bindChecked<Value: Equatable>(to key: Defaults.Key<Value>, value: Value) -> Self {
        addAction { _ in
            defaults[key] = value
        }
        
        defaults.observe(key, tiedToLifetimeOf: self) { [unowned self] change in
            self.isChecked = (change.newValue == value)
        }
        
        return self
    }
}

extension NSSlider {
    func bindDoubleValue(to key: Defaults.Key<Double>) -> Self {
        addAction { sender in
            defaults[key] = sender.doubleValue
        }
        
        defaults.observe(key, tiedToLifetimeOf: self) { [unowned self] change in
            self.doubleValue = change.newValue
        }
        
        return self
    }
}
