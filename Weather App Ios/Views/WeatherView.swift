import SwiftUI

import SwiftUI

func getIcon(weatherCondition: String) -> String {
    var ret = "cloud"
    if weatherCondition == "Clear" {
        ret = "sun.min"
    }
    else if weatherCondition == "Clouds" {
        ret = "cloud"
    }
    else if weatherCondition == "Rain" {
        ret = "cloud.rain"
    }
    return ret
}

func doNothing() {
    print("pressed")
}

struct WeatherView: View {
    var weather: ResponseBody
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let darkBlue = Color(red: 0.527, green: 0.8392, blue: 0.8)
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            VStack {
                
                HStack {
                    Button(action: doNothing) {
                        Label {
                            Text("")
                        } icon: {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Button(action: doNothing) {
                        Label {
                            Text("")
                        } icon: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 10) {
                            Image(systemName: getIcon(weatherCondition: weather.weather[0].main))
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        .padding()
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding([.top, .leading, .bottom], -30.0)
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                        .padding(.leading)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(LinearGradient(gradient: Gradient(colors: [darkBlue, skyBlue]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
