//
//  Image.swift
//  FourSquare
//
//  Created by Kimball Yang on 11/17/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

class ImageAPI {

 
    static let manager = ImageAPI()

    func getImages(ID: String, completionHandler: @escaping (Result<[ImageInfo], AppError>) -> ()) {
        let urlString = "https://api.foursquare.com/v2/venues/\(ID)/photos?client_id=Q0NW3DHOCABZEKYJIEZYFN2JJDBXORYX1MFFYLGA4AFPCPUZ&client_secret=YETGX2Q0UE4HMV0BZGSC0FXWDOJFXLNJVKMEBI2LEJKQQULM&v=20191104"
        print("image \(urlString)")
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
                      return
                  }
            NetworkHelper.manager.performDataTask(withUrl: url , andMethod: .get) { (result) in
                switch result {
                case .failure(let error) :
                    completionHandler(.failure(error))
                case .success(let data):
                    do {
                    let image = try JSONDecoder().decode(ImageModel.self, from: data)
    
                        completionHandler(.success(image.response.photos.items))
                    } catch {
                        print(error)
                        completionHandler(.failure(.other(rawError: error)))
                    }
                }
            }
            
            
        }
    
    }
