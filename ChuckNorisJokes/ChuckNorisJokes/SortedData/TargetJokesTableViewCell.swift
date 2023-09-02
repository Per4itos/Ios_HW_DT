//
//  ChuckNorrisCategoriesTableViewCell.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 28.08.2023.
//

import UIKit

class ChuckNorrisCategoriesTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.numberOfLines = 0
        title.textColor = .black
        return title
    }()
    
    private lazy var subtitleText: UILabel = {
        let subtitleText = UILabel()
        subtitleText.translatesAutoresizingMaskIntoConstraints = false
        subtitleText.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleText.textColor = .black
        return subtitleText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupConstraints() {
        contentView.addSubview(title)
        contentView.addSubview(subtitleText)
        
        NSLayoutConstraint.activate([
            
            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.title.heightAnchor.constraint(equalToConstant: 180),
            self.title.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            self.subtitleText.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: -6),
            self.subtitleText.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
        ])
    }

}
