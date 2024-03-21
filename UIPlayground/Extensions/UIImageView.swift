//
//  UIImageView.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import UIKit

extension UIImageView {
    func download(from url: URL, contentModel mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                      let data, error == nil,
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
