//
//  JLActiveSearchBar.swift
//  JLActiveSearchBar
//
//  Created by 刘业臻 on 16/5/3.
//  Copyright © 2016年 luiyezheng. All rights reserved.
//

import UIKit

@IBDesignable
public class AnimatedSearchBar: UISearchBar, UIGestureRecognizerDelegate {
    
    private lazy var tapRecognizer: UITapGestureRecognizer! = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AnimatedSearchBar.drawoutline))
        tapRecognizer.delegate = self
        return tapRecognizer
        
    }()
    
    private var searchIconImageView: UIImageView!
    
    public var searchField: UITextField!
    
    private var pathLayer: CAShapeLayer!
    
    private var searchImageOne: UIImage? = UIImage(named: "search")
    private var searchImageTwo: UIImage? = UIImage(named: "search1")
    
    @IBInspectable public var duration: CGFloat = 0.45
    @IBInspectable public var outlineColor: UIColor? = UIColor.black
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect, duration: CGFloat, outlineColor: UIColor) {
        super.init(frame: frame)
        
        self.duration = duration
        self.outlineColor = outlineColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override public func draw(_ rect: CGRect) {
        if let index = indexOfSearchFieldInSubviews() {
            searchBarStyle = .minimal
            isTranslucent = true
            backgroundColor = UIColor.clear
            tintColor = UIColor.darkGray
            
    //MARK: -
    //MARK: setup searchFied
            searchField = (subviews[0] ).subviews[index] as? UITextField
            searchField.frame = CGRect(x: 5.0,y: 5.0, width: frame.size.width, height: frame.size.height)
            searchField.backgroundColor = UIColor.clear
            searchField.placeholder = "Search..."
            searchField.isHidden = true
            
        }
        
    //MARK: -
    //MARK: setup searchIconImageView

        searchIconImageView = UIImageView(frame: CGRect(x: self.bounds.maxX - 40, y: self.bounds.minY , width: 18, height: 18))
        searchIconImageView.center.y = bounds.maxY / 2
        searchIconImageView.image = searchImageOne
        searchIconImageView.addGestureRecognizer(tapRecognizer)
        searchIconImageView.isUserInteractionEnabled = true
        searchIconImageView.contentMode = .scaleToFill
        addSubview(searchIconImageView)
        
        super.draw(rect)
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0] 
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        return index
    }
    
    @objc func drawoutline() {
        
    //MARK: -
    //MARK: draw outline
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.maxX,y: bounds.minY))
        path.addLine(to: CGPoint(x:bounds.minX + 5,y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.minX + 5,y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX,y: bounds.maxY))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: path.bounds, cornerRadius: 20.0).cgPath
        shapeLayer.strokeColor = outlineColor!.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineJoin = CAShapeLayerLineJoin.bevel
        self.pathLayer = shapeLayer
        layer.addSublayer(self.pathLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = TimeInterval(duration)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        self.pathLayer.add(pathAnimation, forKey: "strokeEnd")
        
    //MARK: -
    //MARK: setup searchBar state and animate

        searchField!.isHidden = false
        becomeFirstResponder()
        self.searchIconImageView.isHidden = true
        self.setImage(searchImageTwo, for: .search, state: .normal)
        
        let currentAdjustment = self.positionAdjustment(for: .search)
        UIView.animate(withDuration: TimeInterval(duration), animations: {() -> Void in
            self.setPositionAdjustment(UIOffset(horizontal: -self.bounds.width, vertical: currentAdjustment.vertical), for: .search)
            }, completion: {(finished: Bool) -> Void in
                self.setPositionAdjustment(currentAdjustment, for: .search)
            
        })
        
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.layoutIfNeeded()
        }
        
    }
    
    //reset the searchBar state
    public func reSet() {
        self.pathLayer.removeFromSuperlayer()
        self.setImage(nil, for: .search, state: .normal)
        self.searchIconImageView.isHidden = false
        searchField.isHidden = true
        resignFirstResponder()
    }
    //MARK: -
    //MARK: prepareForInterfaceBuilder

    override public func prepareForInterfaceBuilder() {
        let bundle = Bundle(for: AnimatedSearchBar.self)
        self.searchImageOne = UIImage(named: "search", in: bundle, compatibleWith: self.traitCollection)
        self.searchImageTwo = UIImage(named: "search1", in: bundle, compatibleWith: self.traitCollection)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.maxX,y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.minX + 5,y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.minX + 5,y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX,y: bounds.maxY))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: path.bounds, cornerRadius: 20.0).cgPath
        shapeLayer.strokeColor = outlineColor!.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineJoin = CAShapeLayerLineJoin.bevel
        self.pathLayer = shapeLayer
        layer.addSublayer(self.pathLayer)

        
    }
    
}
