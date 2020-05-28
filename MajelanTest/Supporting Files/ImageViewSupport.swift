//
//  ImageViewSupport.Swift
//  MajelanTest
//
//  Created by Florian DERONE on 26/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    ///
    /// This function is used to download and load an image into an image view
    ///
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, session: URLSession = URLSession.shared) -> URLSessionDataTask {
        contentMode = mode
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { self.image = image }
        }
        task.resume()
        
        return task
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, session: URLSession = URLSession.shared) -> URLSessionDataTask? {
        guard let url = URL(string: link) else { return nil}
        return downloaded(from: url, contentMode: mode, session: session)
    }
        
}
