//
//  ViewController.swift
//  WhenDemo
//
//  Created by Pawel Szymanski on 14/03/2020.
//  Copyright © 2020 Paweł Szymański. All rights reserved.
//

import UIKit
import When

enum ScreenLayout {
    case small
    case medium
    case large
    case huge
    
    init(width: CGFloat) {
        switch width {
        case ...375: self = .small
        case ...768: self = .medium
        case ...1024: self = .large
        default: self = .huge
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(with: view.bounds.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in self.update(with: size.width) }, completion: nil)
    }
    
    func update(with viewWidth: CGFloat) {
        let layout = ScreenLayout(width: viewWidth)
        
        label.text = evaluate(
            give("iPad Landscape", when.ipad.anyLandscape),
            give("iPad Portrait", when.ipad.anyPortrait),
            give("iPhone Landscape", when.iphone.anyLandscape),
            give("iPhone Portrait", when.iphone.anyPortrait)
        )
        
        label.font = evaluate(
            give(UIFont.systemFont(ofSize: 10), when.small(layout)),
            give(UIFont.systemFont(ofSize: 12), when.medium(layout)),
            give(UIFont.systemFont(ofSize: 16), when.large(layout)),
            give(UIFont.systemFont(ofSize: 20), when.huge(layout))
        )
                
        // Using convenience function for
        label.numberOfLines = evaluate(layout, small: 1, medium: 2, large: 3, huge: 4)
        label.lineBreakMode = evaluate(layout, small: .byWordWrapping, medium: .byClipping, large: .byCharWrapping, huge: .byTruncatingMiddle)
        label.textColor = evaluate(ipad: .blue, iphone: .red)
        
        // Default value provided
        label.textAlignment = evaluate(default: .center,
                                       give(.left, when.ipad.anyLandscape),
                                       give(.right, when.ipad.anyPortrait),
                                       give(.center, when.iphone))
    }
}

// You can add your conditions by extending the If class
extension If {    
    func small(_ layout: ScreenLayout) -> If {
        return condition { layout == .small }
    }
    
    func medium(_ layout: ScreenLayout) -> If {
        return condition { layout == .medium }
    }

    func large(_ layout: ScreenLayout) -> If {
        return condition { layout == .large }
    }
    
    func huge(_ layout: ScreenLayout) -> If {
        return condition { layout == .huge }
    }
}

// You can also create your own function for your convenience
func evaluate<Value>(_ layout: ScreenLayout, small: @autoclosure () -> Value, medium: @autoclosure () -> Value, large: @autoclosure () -> Value, huge: @autoclosure () -> Value) -> Value {
    return evaluate(default: medium(),
                    give(small(), when.small(layout)),
                    give(medium(), when.medium(layout)),
                    give(large(), when.large(layout)),
                    give(huge(), when.huge(layout)))
}

func evaluate<Value>(ipad: @autoclosure () -> Value, iphone: @autoclosure () -> Value) -> Value {
    return evaluate(default: iphone(),
                    give(iphone(), when.iphone),
                    give(ipad(), when.ipad))
}

