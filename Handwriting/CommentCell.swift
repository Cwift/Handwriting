//
//  CommentCell.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/6.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: class {
    func commentCell(_ commentCell: CommentCell, _ commentModel: CommentModel)
}

class CommentCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    
    var commentModel: CommentModel!
    var indexPath: IndexPath!
    weak var delegate: CommentCellDelegate?
    
    @IBAction func jumpButton(_ sender: UIButton) {
        self.delegate?.commentCell(self, commentModel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    
}
