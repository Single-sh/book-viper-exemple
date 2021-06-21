//
//  HeaderCollectionReusableView.swift
//  BookViperExemple
//
//  Created by Aleksandr Shevchenko on 16.06.2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    private let title = UILabel()
    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        lineView.backgroundColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1)
    }
    
    func setTitle(text: String) {
        title.text = text.uppercased()
    }
    
}
