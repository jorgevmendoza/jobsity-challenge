//
//  PeopleHeaderView.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class PeopleHeaderView:UIView {
    
    var poster:UIImageView?
    
    var title:UILabel?
    
    var composed:UILabel?
    
    struct HeaderData {
        
        let person:Person?
    }
    
    var headerData:HeaderData? {
        
        didSet{
            
            title?.text = headerData?.person?.name ?? ""
            
            composed?.text = "\(headerData?.person?.birthday ?? "" ) \(headerData?.person?.gender ?? "") \(headerData?.person?.country?.code ?? "") "
            
            poster?.image = UIImage(named: "empty-image")
            
            poster?.moa.onSuccess = { image in
                return image
            }
            
            poster?.moa.url = headerData?.person?.image?.medium
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(){
        
        poster = UIImageView()
        
        poster?.contentMode = .scaleAspectFit
        
        self.addSubview(poster!)
        
        
        title = UILabel()
        
        title?.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        title?.textColor = Colors.black
        
        title?.textAlignment = .center
        
        title?.numberOfLines = 2
        
        self.addSubview(title!)
        
        
//        season = UILabel()
//
//        season?.font = UIFont.boldSystemFont(ofSize: 16.0)
//
//        season?.textColor = Colors.black
//
//        season?.numberOfLines = 2
        
        //self.addSubview(season!)
        
        
        composed = UILabel()
        
        composed?.font = UIFont.systemFont(ofSize: 16.0)
        
        composed?.textColor = Colors.lightGray
        
        composed?.textAlignment = .center
        
        composed?.numberOfLines = 2
        
        self.addSubview(composed!)
        
        
        
//        genresStack = UIStackView()
//        
//        genresStack?.alignment = .center
//        
//        genresStack?.axis = .horizontal
//        
//        genresStack?.distribution = .fillEqually
        
        //        genresStack?.addArrangedSubview(mainCategory!)
        //
        //        genresStack?.addArrangedSubview(secondCategory!)
        
//        genresStack?.spacing = 5.0
        
        // self.addSubview(genresStack!)
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        let imageHeight:CGFloat = CGFloat(180.0)
        let scaleFactor:CGFloat = CGFloat(0.7118)
        let width = UIScreen.main.bounds.width / 2
        let leftOrigin = width - ((imageHeight * scaleFactor) / 2)
        
        
        title?.autoPinEdge(.top, to: .top, of: self, withOffset: 10.0)
        title?.autoPinEdge(.left, to: .left, of: self, withOffset: 25.0)
        title?.autoPinEdge(.right, to: .right, of: self, withOffset: -25.0)
        
        poster?.autoPinEdge(.top, to: .bottom, of: title!, withOffset: 18.0)
        poster?.autoPinEdge(.left, to: .left, of: self, withOffset: leftOrigin )
        poster?.autoSetDimension(.height, toSize: imageHeight)
        poster?.autoSetDimension(.width, toSize: (imageHeight * scaleFactor))
        
        composed?.autoPinEdge(.top, to: .bottom, of: poster!, withOffset: 10.0)
        composed?.autoPinEdge(.left, to: .left, of: self, withOffset: 75.0)
        composed?.autoPinEdge(.right, to: .right, of: self, withOffset: -75.0)
        
    }
    
}

