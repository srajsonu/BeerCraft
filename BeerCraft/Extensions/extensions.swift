//
//  extensions.swift
//  BeerCraft
//
//  Created by ARY@N on 28/07/19.
//

import UIKit

public func cellLayer(cellType : UICollectionViewCell) {
    
    cellType.layer.cornerRadius = 10
    cellType.layer.borderWidth = 0.2
    cellType.layer.shadowColor = UIColor.lightGray.cgColor
    cellType.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    cellType.layer.shadowRadius = 2.0
    cellType.layer.shadowOpacity = 2.0
    cellType.layer.masksToBounds = false
    cellType.layer.shadowPath = UIBezierPath(roundedRect: cellType.bounds, cornerRadius: cellType.contentView.layer.cornerRadius).cgPath
}

public func views(view : UIView) {
    
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 0.2
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowOpacity = 2.0
    view.layer.masksToBounds = false
}

public func buttons(view : UIButton) {
    
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 0.2
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowOpacity = 2.0
    view.layer.masksToBounds = false
}
