//
//  MealAPI.swift
//  finalproj2
//
//  Created by Dumindu Harshana on 2024-04-16.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    // Add more cases as needed
}
private let apiKey = "1"
enum MealAPIError: Error {
    case invalidURL
    case noData
    case decodingError
}
struct MealResponse: Codable {
    let meals: [Meal]?
}
struct CategoryResponse: Codable {
    let categories: [Category]
}
enum APIError: Error {
    case noData
    case decodingError
    // Add more cases as needed
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
struct MealLookupResponse: Codable {
    let meals: [Meal]
}



class MealAPI {
    static let shared = MealAPI()
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    func fetchData(for endpoint: String, completion: @escaping (Result<[Meal], MealAPIError>) -> Void) {
            guard let url = URL(string: "\(baseURL)\(endpoint)") else {
                completion(.failure(.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(MealResponse.self, from: data)
                    if let meals = response.meals {
                        completion(.success(meals))
                    } else {
                        completion(.failure(.decodingError))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
   

    
    func searchMealByName(name: String, completion: @escaping (Result<[Meal], MealAPIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)search.php?s=\(name)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MealResponse.self, from: data)
                if let meals = response.meals {
                    completion(.success(meals))
                } else {
                    completion(.failure(.decodingError))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    func getAllCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
            let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CategoryResponse.self, from: data)
                    completion(.success(response.categories))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

