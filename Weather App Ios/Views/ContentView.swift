//
//  ContentView.swift
//  Weather App Ios
//
//  Created by Louis AB on 18/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let darkBlue = Color(red: 0.527, green: 0.8392, blue: 0.8)
    
    var body: some View {
        
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                }
                else {
                    LoadingView()
                        .task{
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [darkBlue, skyBlue]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
