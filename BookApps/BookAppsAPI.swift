//
//  BookAppsAPI.swift
//  BookApps
//
//  Created by Ayush Singh on 05/01/22.
//

import Foundation
import UIKit
import SwiftUI

struct Data: Identifiable {
    var id = UUID()
    var company: String
    var name: String
}

public struct BookAppsAPI: View  {
    
    @State var modelData = [
        Data(company: "Company", name: "Name")
    ]
    
    
    
    
    public init() {}
    
    public var body: some View {
        
        List(modelData) { data in
            HStack {
                Text("\(data.name)")
                Spacer()
                VStack {
                    
                    Text(data.company)
                        .bold()
                        .foregroundColor(.gray)
                    
                    
                }
            }
            
        }.onAppear(perform: loadAPI)
        
        
    }
    
    
    private func loadAPI() {
        
        let urlApi = "https://run.mocky.io/v3/8260aa5d-8af8-4cff-999e-6e81b217f0ba"
        print(urlApi)
        let url = URL(string: urlApi)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        if let json = try JSONSerialization.jsonObject(with: content) as? [String: Any] {
                            
                            if let content = json["clients"] as? [[String:String]] {
                                for category in content {
                                    
                                    guard let name =  category["name"],
                                          let company =  category["company"]
                                            
                                    else {
                                        return
                                    }
                                    
                                    modelData.append(Data(company: company, name: name))
                                    
                                    print( name, company)
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                    catch
                    {
                        print("error in JSONSerialization")
                    }
                }
            }
        }
        task.resume()
        
    }
    
    
}

public struct BookAppAPI_Previews: PreviewProvider {
    public init() {}
    
    public static var previews: some View {
        
        BookAppsAPI()
    }
}




