//
//  UIKit.swift
//  When
//
//  Created by Pawel Szymanski on 17/03/2020.
//  Copyright © 2020 Paweł Szymański. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension If {
    var iphone: If {
        return condition { UIDevice.current.userInterfaceIdiom == .phone }
    }
    var ipad: If {
         return condition { UIDevice.current.userInterfaceIdiom == .pad }
    }
    var tv: If {
         return condition { UIDevice.current.userInterfaceIdiom == .tv }
    }
    var carPlay: If {
         return condition { UIDevice.current.userInterfaceIdiom == .carPlay }
    }
    var idiomUnspecified: If {
         return condition { UIDevice.current.userInterfaceIdiom == .unspecified }
    }
}

public extension If {
    var landscapeLeft: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == .some(.landscapeLeft)
            } else {
                return UIApplication.shared.statusBarOrientation == .landscapeLeft
            }
        }
    }
    var landscapeRight: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == .some(.landscapeRight)
            } else {
                return UIApplication.shared.statusBarOrientation == .landscapeLeft
            }
        }
    }
    var anyLandscape: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
            } else {
                return UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
    }
    var portrait: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == .some(.portrait)
            } else {
                return UIApplication.shared.statusBarOrientation == .portrait
            }
        }
    }
    var portraitUpsideDown: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == .some(.portraitUpsideDown)
            } else {
                return UIApplication.shared.statusBarOrientation == .portraitUpsideDown
            }
        }
    }
    var anyPortrait: If {
        return condition {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? false
            } else {
                return UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
#endif
