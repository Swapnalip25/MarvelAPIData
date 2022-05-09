//
//  ImageLoader.swift
//  MarvelData
//
//  Created by Swapnali Patil on 09/05/22.
//

import Foundation
import SDWebImage

protocol ImageLoader {
    func setImage(imageView: UIImageView, url: URL)
}

extension ImageLoader {
    func setImage(imageView: UIImageView, url: URL) {
        imageView.image = nil
        imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: CellConstants.placeholderImage))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }
}
