//
//  Download.swift
//  AnimatedCharts
//
//  Created by Adrian Suryo Abiyoga on 06/01/25.
//

import SwiftUI

struct Download: Identifiable {
    var id: UUID = .init()
    var date: Date
    var value: Double
    ///Animated Properties
    var isAnimated: Bool = false
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}

var sampleDownloads: [Download] = [
        .init(date: .createdDate(1, 8, 2023), value: 2500),
        .init(date: .createdDate(1, 9, 2023), value: 3500),
        .init(date: .createdDate(1, 10, 2023), value: 1500),
        .init(date: .createdDate(1, 11, 2023), value: 9500),
        .init(date: .createdDate(1, 12, 2023), value: 1950),
        .init(date: .createdDate(1, 13, 2024), value: 5100),
        .init(date: .createdDate(1, 14, 2024), value: 6000),
        .init(date: .createdDate(1, 15, 2024), value: 3850),
        .init(date: .createdDate(1, 16, 2025), value: 7700)
    ]
    
    extension Date {
        static func createdDate(_ day: Int, _ month: Int, _ year: Int) -> Date {
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            
            let calendar = Calendar.current
            let date = calendar.date(from: components) ?? .init()
            
            return date
        }
    }
    
    

