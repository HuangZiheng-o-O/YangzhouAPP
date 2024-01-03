import SwiftUI
import MapKit
import CoreLocation
struct ArticleView: View {
    @State var article : Article
      // 设置一个默认的坐标
    @State private var coordinate = CLLocationCoordinate2D()

    @EnvironmentObject var userData:UserData
    @State private var quantity = 0
    @State var heart = "heart.fill"
    // 创建一个字典来存储每个景点的经纬度
    let locations: [Int: CLLocationCoordinate2D] = [
        1: CLLocationCoordinate2D(latitude: 32.41478, longitude: 119.42809), // 瘦西湖
        2: CLLocationCoordinate2D(latitude: 32.39143, longitude: 119.45560), // 何园
        3: CLLocationCoordinate2D(latitude: 32.40494, longitude: 119.45035), // 个园
        4: CLLocationCoordinate2D(latitude: 32.40494, longitude: 119.45035), // 东关街
        // 以此类推...
    ]

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader{reader in
                    Image(article.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY + 300)
                }
                .frame(height: 280)

                VStack(alignment: .leading,spacing: 15){
                     Text(article.title)
                        .font(.system(size: 35, weight: .bold))
                    
                    
                    HStack(spacing: 10){
                        
                        ForEach(1..<5){_ in
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    HStack {
                        Text(article.date)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,5)
                        Spacer()
                    }
         
                    Button(action: {
                        // 根据 article 的 id 从 locations 字典中获取对应的经纬度并设置 coordinate
                        if let location = locations[article.id] {
                            self.coordinate = location
                        }
                        
                        // 打开内置地图应用并导航到目标位置
                        let placemark = MKPlacemark(coordinate: self.coordinate)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = article.title
                        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                    }) {
                        Text("导航")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()

                    // 显示地图和大头针
                    MapView(coordinate: $coordinate)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 300)
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: -35)
            })
            Spacer()
        }
        .onAppear(perform: {
            // 在视图出现时，根据 article 的 id 从 locations 字典中获取对应的经纬度并设置 coordinate
            if let location = locations[article.id] {
                self.coordinate = location
            }
        })
    }
}
