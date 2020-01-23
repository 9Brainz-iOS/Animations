//
//  Animation.swift
//  AnimationsDemo
//
//  Created by meet ratanpara on 23/01/20.
//  Copyright © 2020 meet ratanpara. All rights reserved.
//

import UIKit

public extension UIView {
    
   func fadeColor(toColor: UIColor = UIColor.red,
                                    duration: TimeInterval = 1,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
      UIView.animate(
          withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            
            self.backgroundColor = toColor
            },
        completion: completion)
      return self
  }
    
    func fadeIn(duration: TimeInterval = 1,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
       isHidden = false
       alpha = 0
       UIView.animate(
         withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
           
           self.alpha = 1
         }, completion: completion)
       return self
     }
       
       func fadeOut(duration: TimeInterval = 1,
                                     delay: TimeInterval = 0,
                                     completion: ((Bool) -> Void)? = nil) -> UIView {
       UIView.animate(
         withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            
           self.alpha = 0
           },
         completion: completion)
       return self
     }
    
   
    
   func bounceIn(from edge: Anim = .none,
                                   x: CGFloat = 0,
                                   y: CGFloat = 0,
                                   duration: TimeInterval = 1,
                                   delay: TimeInterval = 0,
                                   completion: ((Bool) -> Void)? = nil) ->  UIView {
    let offset = offsetFor(edge: edge)
    transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
    isHidden = false
    UIView.animate(
      withDuration: duration, delay: delay, usingSpringWithDamping: 0.58, initialSpringVelocity: 3,
      options: .curveEaseOut, animations: {
        
        self.transform = .identity
        self.alpha = 1
        },
        completion: completion)
    return self
  }
   
   func bounceOut(to edge: Anim = .none,
                                    x: CGFloat = 0,
                                    y: CGFloat = 0,
                                    duration: TimeInterval = 1,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
    let offset = offsetFor(edge: edge)
    let delta = CGPoint(x: offset.x + x, y: offset.y + y)
    let endTransform = CGAffineTransform(translationX: delta.x, y: delta.y)
    let prepareTransform = CGAffineTransform(translationX: -delta.x * 0.2, y: -delta.y * 0.2)
    
    UIView.animateKeyframes(
      withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2)
        {
            self.transform = prepareTransform
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2)
        {
            self.transform = prepareTransform
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6)
        {
            self.transform = endTransform
        }
        },
      completion: completion)
    return self
  }
    
    func slideIn(from edge: Anim = .none,
                                    x: CGFloat = 0,
                                    y: CGFloat = 0,
                                    duration: TimeInterval = 1,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
      let offset = offsetFor(edge: edge)
      transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
      
      isHidden = false
      UIView.animate(
        withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2,
        options: .curveEaseOut, animations: {
        
          self.transform = .identity
          self.alpha = 1
          },
        completion: completion)
      return self
    }
      
      func slideOut(to edge: Anim = .none,
                                     x: CGFloat = 0,
                                     y: CGFloat = 0,
                                     duration: TimeInterval = 1,
                                     delay: TimeInterval = 0,
                                     completion: ((Bool) -> Void)? = nil) -> UIView {
      let offset = offsetFor(edge: edge)
      let endTransform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
      UIView.animate(
        withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
          
          self.transform = endTransform
          },
        completion: completion)
      return self
    }
   
   func popIn(fromScale: CGFloat = 0.5,
                                duration: TimeInterval = 1,
                                delay: TimeInterval = 0,
                                completion: ((Bool) -> Void)? = nil) -> UIView {
    isHidden = false
    alpha = 0
    transform = CGAffineTransform(scaleX: fromScale, y: fromScale)
    UIView.animate(
      withDuration: duration, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
      options: .curveEaseOut, animations: {
        
        self.transform = .identity
        self.alpha = 1
        },
      completion: completion)
    return self
  }
    
   func popOut(toScale: CGFloat = 0.5,
                                 duration: TimeInterval = 1,
                                 delay: TimeInterval = 0,
                                 completion: ((Bool) -> Void)? = nil) -> UIView {
    let endTransform = CGAffineTransform(scaleX: toScale, y: toScale)
    let prepareTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    UIView.animateKeyframes(
      withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {
        
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2)
            {
                self.transform = prepareTransform
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3)
            {
                self.transform = prepareTransform
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5)
            {
                self.transform = endTransform
                self.alpha = 0
            }
        },
      completion: completion)
    return self
  }
   
   func hop(toward edge: Anim = .none,
                              amount: CGFloat = 0.4,
                              duration: TimeInterval = 1,
                              delay: TimeInterval = 0,
                              completion: ((Bool) -> Void)? = nil) -> UIView {
    var dx: CGFloat = 0, dy: CGFloat = 0, ds: CGFloat = 0
    if edge == .none
    {
      ds = amount / 2
    }
    
    else if edge == .left || edge == .right
    {
      dx = (edge == .left ? -1 : 1) * self.bounds.size.width * amount;
      dy = 0
    }
    
    else
    {
      dx = 0
      dy = (edge == .top ? -1 : 1) * self.bounds.size.height * amount;
    }
    
    UIView.animateKeyframes(
      withDuration: duration, delay: delay, options: .calculationModeLinear, animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.28)    {
          let t = CGAffineTransform(translationX: dx, y: dy)
          self.transform = t.scaledBy(x: 1 + ds, y: 1 + ds)
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 0.28)
        {
            self.transform = .identity
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.56, relativeDuration: 0.28)
        {
            let t = CGAffineTransform(translationX: dx * 0.5, y: dy * 0.5)
            self.transform = t.scaledBy(x: 1 + ds * 0.5, y: 1 + ds * 0.5)
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.84, relativeDuration: 0.16)
        {
            self.transform = .identity
        }
    }, completion: completion)
    return self
  }
    
   func shake(toward edge: Anim = .none,
                                amount: CGFloat = 0.15,
                                duration: TimeInterval = 1,
                                delay: TimeInterval = 0,
                                completion: ((Bool) -> Void)? = nil) -> UIView {
    let steps = 8
    let timeStep = 1.0 / Double(steps)
    var dx: CGFloat, dy: CGFloat
    
    if edge == .left || edge == .right
    {
      dx = (edge == .left ? -1 : 1) * self.bounds.size.width * amount;
      dy = 0
    }
    
    else
    {
      dx = 0
      dy = (edge == .top ? -1 : 1) * self.bounds.size.height * amount;
    }
    
    UIView.animateKeyframes(
      withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {
        var start = 0.0
        for i in 0..<(steps - 1) {
          UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep)
          {
            self.transform = CGAffineTransform(translationX: dx, y: dy)
          }
          
          if (edge == .none && i % 2 == 0) {
            swap(&dx, &dy)
            dy *= -1
          }
            
          dx *= -0.85
          dy *= -0.85
          start += timeStep
        }
        
        UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep)
        {
            self.transform = .identity
        }
        },
      completion: completion)
    return self
  }
    
  private func offsetFor(edge: Anim) -> CGPoint {
    if let parentSize = self.superview?.frame.size {
      switch edge {
      case .none: return CGPoint.zero
      case .top: return CGPoint(x: 0, y: -frame.maxY)
      case .bottom: return CGPoint(x: 0, y: parentSize.height - frame.minY)
      case .left: return CGPoint(x: -frame.maxX, y: 0)
      case .right: return CGPoint(x: parentSize.width - frame.minX, y: 0)
      }
    }
    return .zero
  }
}

public enum Anim {
  case none
  case top
  case bottom
  case left
  case right
}
