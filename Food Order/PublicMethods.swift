//
//  PublicMethods.swift
//  Food Order
//
//  Created by Ramesh Pendyala on 26/03/25.
//

import UIKit

var publicOutlets: [FoodOutlet] = []

func generateRandomFoodOutlets(count: Int) -> [FoodOutlet] {
    if !publicOutlets.isEmpty {
        return publicOutlets
    }else {
        let sampleNames = ["Burger King", "Pizza Hut", "KFC", "Starbucks", "McDonald's", "Subway", "Domino's", "Chipotle", "Taco Bell", "Wendy's"]
        let sampleAddresses = [
            "123 MG Road, Bangalore, Karnataka",
            "456 Connaught Place, New Delhi, Delhi",
            "789 Marine Drive, Mumbai, Maharashtra",
            "321 Park Street, Kolkata, West Bengal",
            "654 Banjara Hills, Hyderabad, Telangana"
        ]
        
        var outlets: [FoodOutlet] = []
        
        for _ in 0..<count { 
            let randomName = sampleNames.randomElement() ?? "Unknown"
            let randomAddress = sampleAddresses.randomElement() ?? "Unknown Address"
            let randomRating = Int.random(in: 1...5)
            let randomLat = CGFloat.random(in: 8.4...37.6)
            let randomLong = CGFloat.random(in: 68.7...97.25)
            let randomFavourite = Bool.random()
            
            let outlet = FoodOutlet(
                name: randomName,
                rating: randomRating,
                address: randomAddress,
                lat: randomLat,
                long: randomLong,
                isFavourite: randomFavourite
            )
            
            outlets.append(outlet)
        }
        publicOutlets = outlets
        return outlets
    }
}
