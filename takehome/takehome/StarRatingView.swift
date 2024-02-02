//
//  StarRatingView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double // Rating value e.g., 4.69
    let maximumRating: Int = 5 // Maximum number of stars you want to show
    
    // Calculate the number of full stars
    var fullStars: Int {
        return Int(rating)
    }
    
    // Calculate if we have a half star
    var halfStar: Bool {
        return rating - Double(fullStars) >= 0.5
    }
    
    // Calculate the number of empty stars
    var emptyStars: Int {
        return maximumRating - fullStars - (halfStar ? 1 : 0)
    }
    
    var body: some View {
        HStack(spacing: -4) {
            // Full stars
            ForEach(0..<fullStars, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            // Half star
            if halfStar {
                Image(systemName: "star.leadinghalf.fill")
                    .foregroundColor(.yellow)
            }
            
            // Empty stars
            ForEach(0..<emptyStars, id: \.self) { _ in
                Image(systemName: "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    StarRatingView(rating:4.5)
}
