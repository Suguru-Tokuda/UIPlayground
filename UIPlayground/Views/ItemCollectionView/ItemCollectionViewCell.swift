//
//  ItemCollectionViewCell.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ItemCollectionViewCell"

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let itemLabel: UILabel = {
        let itemLabel = UILabel()
        itemLabel.numberOfLines = 2
        itemLabel.lineBreakMode = .byTruncatingTail
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.font = .systemFont(ofSize: 12)
        itemLabel.textColor = .black
        return itemLabel
    }()

    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = .black
        return priceLabel
    }()

    private let addToCartButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.setTitle("+ Add", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        if var buttonConfig = button.configuration {
            buttonConfig.contentInsets = .init(top: 10, leading: 40, bottom: 10, trailing: 40)
            button.configuration = buttonConfig
        }
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ItemCollectionViewCell {
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 8

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
    }

    private func applyConstraints() {
        let padding: CGFloat = 10

        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ]

        let itemImageViewConstraints = [
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 56),
            itemImageView.widthAnchor.constraint(equalToConstant: 56)
        ]

        let itemLabelConstraints = [
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: padding * 2),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        let priceLabelConstraints = [
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: itemLabel.leadingAnchor),
        ]

        itemLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        priceLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)

        let addToCartButtonConstraints = [
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addToCartButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ]

        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(itemImageViewConstraints)
        NSLayoutConstraint.activate(itemLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(addToCartButtonConstraints)
    }
}

extension ItemCollectionViewCell {
    func configure(itemModel: ItemModel) {
        itemImageView.download(from: URL(string: itemModel.imageURL)!)
        itemLabel.text = itemModel.itemName
        priceLabel.text = itemModel.itemPrice.toCurrencyStr()
    }
}
