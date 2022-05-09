//
//  ComicDetailsViewController.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import UIKit
import SDWebImage

class ComicDetailsViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imgCharactersThumbnail: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    var presenter: ComicDetailsPresenter?
    var configurator: ComicDetailsConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(comicDetailsViewController: self)
        self.loadDataOnUI()
    }

}

extension ComicDetailsViewController: ComicDetailsOutput, ImageLoader {
    func loadDataOnUI() {
        if let characterData = self.presenter?.getComicData() {
            if let http = URL(string: characterData.thumbnail.path + CellConstants.imageExtension), var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) {
                comps.scheme = CellConstants.httpsScheme
                if let https = comps.url {
                    self.setImage(imageView: self.imgCharactersThumbnail, url: https)
                }
            }
            self.lblTitle.text = characterData.title
            self.lblDescription.text = characterData.resultDescription
        }
    }
}
