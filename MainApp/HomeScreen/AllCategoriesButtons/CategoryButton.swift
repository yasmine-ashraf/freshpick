//
//  CategoryButton.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import UIKit

class CategoryButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0.4, height: 0.1)
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    private let myImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let viewModel: CategoryButtonViewModel?
    let myButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        return button
    }()
    init(with viewModel: CategoryButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubviews()
        configure(with: viewModel)
    }
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviews() {
        guard !myTitleLabel.isDescendant(of: self) else {
            return
        }
        addSubview(myTitleLabel)
        addSubview(myImageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 2, y: 10, width: self.frame.width-4, height: (self.height-10)/2)
        myTitleLabel.frame = CGRect(x: 1, y: myImageView.bottom , width: self.width-2, height: (self.height-10)/2)
    }
    public func configure(with viewModel: CategoryButtonViewModel) {
        addSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 8
        myTitleLabel.text = viewModel.title
        myImageView.image = UIImage(named: viewModel.imageName)
        self.backgroundColor = viewModel.bgColor
    }
}
