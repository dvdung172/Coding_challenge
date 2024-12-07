//
//  UIImageView+Extension.swift
//  Coding_challenge
//
//  Created by Dung-pc on 05/12/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        DispatchQueue(label: "queue", attributes: .concurrent).async {
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.image =  UIImage(named: "Default_image")
                }
                return
            }
            
            let request = URLRequest(url: url)
            
            if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: cachedResponse.data)
                }
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.image =  UIImage(named: "Default_image")
                    }
                    return
                }
                
                if let response = response, let httpURLResponse = response as? HTTPURLResponse {
                    let cachedResponse = CachedURLResponse(response: httpURLResponse, data: data)
                    URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
        
        
        
    }
}
