//
//  SortedJokesTableViewCell.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 28.08.2023.
//

import UIKit

class SortedJokesTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.numberOfLines = 0
        title.textColor = .black
        return title
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
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupConstraints() {
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            
            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.title.heightAnchor.constraint(equalToConstant: 180),
            self.title.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12)
          
        ])
    }
    
    
    func configure(category: String ) {
        self.title.text = category
        
    }
}
