//
//  WeatherRow.swift
//  Weather App Ios
//
//  Created by Louis AB on 18/07/2022.
//

import SwiftUI


struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let darkBlue = Color(red: 0.527, green: 0.8392, blue: 0.8)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
                    .foregroundColor(darkBlue)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
