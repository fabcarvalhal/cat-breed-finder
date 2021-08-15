//
//  TheCatApiClient.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

protocol TheCatApiClientProtocol: AnyObject {
    
    func getBreeds(request: CatBreedListRequest,
                   completion: @escaping (Result<CatBreedListResponse>) -> Void)
}

final class TheCatApiClient: BaseApiClient, TheCatApiClientProtocol {
    
    func getBreeds(request: CatBreedListRequest,
                   completion: @escaping (Result<CatBreedListResponse>) -> Void) {
        let endpoint = TheCatApiEndpoint.breeds
        
        do {
            let request = try URLRequestBuilder(with: endpoint.baseUrl)
                .set(path: endpoint.path)
                .set(headers: endpoint.headers)
                .set(method: endpoint.method)
                .set(params: .query(request.toDictionary()))
                .build()
            
            makeRequest(with: request,
                        completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
