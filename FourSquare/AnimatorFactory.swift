//
//  AnimatorFactory.swift
//  FourSquare
//
//  Created by Kimball Yang on 11/19/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class AnimatorFactory {
  
  static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
    let scale = UIViewPropertyAnimator(
      duration: 0.5,
      curve: .easeIn
    )
    
    scale.addAnimations {
      view.alpha = 1
    }
    
    scale.addAnimations({
        view.transform = CGAffineTransform.identity
      },
      delayFactor: 0.25
    )
    
    scale.addCompletion { _ in
      print("Ready!")
    }
    
    return scale
  }
}
