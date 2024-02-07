//
//  ContentView.swift
//  test
//
//  Created by こばとここあ on 2024/02/07.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var n:Float64 = 0.0
    @State var totalMinedKKP:Float64 = 0
    
    @State var kokopiAmount:UInt64 = 0
    @State var kokopiOutput:Float64 = 1.0
    @State var kokopiPrice:Float64 = 10
    
    @State var pizzaAmount:UInt64
    @State var pizzaOutput:Double
    @State var pizzaPrice:Double
    
    @State var nikuAmount:UInt64
    @State var nikuOutput:Double
    @State var nikuPrice:Double
    
    @State var isHosonaga:Bool = false
    init() {
        self.n = 0.0
        self.kokopiAmount = 0
        self.kokopiPrice = 10.0
        
        self.pizzaAmount = 0
        self.pizzaOutput = 15
        self.pizzaPrice = 100
        
        self.nikuAmount = 0
        self.nikuOutput = 100
        self.nikuPrice = 1700
        
        self.isHosonaga = false
    }
    var body: some View {
        GeometryReader3D {
            proxy3D in
            VStack {
                Text("TAP TAP TAP").font(.largeTitle)
                HStack {
                    VStack {
                        Text(String(format: "%.0f Pt",n)).font(.extraLargeTitle)
                        Text(String(format: "(%.0f Pt/sec)",calcKoinInc())).font(.headline)
                        Button(action:{
                            n+=1;
                        },label:{
                            Circle()
                                .fill(Color.orange)
                                .frame(width:200, height: 200)
                        })
                        .overlay(Text("Tap!").font(.title))
                        
                        Group {
                            if isHosonaga {
                                VStack {
                                    HStack {
                                        Text(String(kokopiAmount)).font(.title)
                                        Text(String(format: "Kokopi COST:%.0f",kokopiPrice)).font(.headline)
                                        Button(action:{
                                            buyKokopi()
                                        },label:{
                                            Text("BUY")
                                        }).disabled(n<kokopiPrice)
                                    }
                                    HStack {
                                        Text(String(pizzaAmount)).font(.title)
                                        Text(String(format: "Pizza COST:%.0f",pizzaPrice)).font(.headline)
                                        Button(action:{
                                            buyPizza()
                                        },label:{
                                            Text("BUY")
                                        }).disabled(n<pizzaPrice)
                                    }
                                    HStack {
                                        Text(String(nikuAmount)).font(.title)
                                        Text(String(format: "Niku COST:%.0f",nikuPrice)).font(.headline)
                                        Button(action:{
                                            buyNiku()
                                        },label:{
                                            Text("BUY")
                                        }).disabled(n<nikuPrice)
                                    }
                                }
                            }
                        }
                        
                    }
                    Group {
                        if !isHosonaga {
                            VStack {
                                HStack {
                                    Text(String(kokopiAmount)).font(.title)
                                    Text(String(format: "Kokopi COST:%.0f",kokopiPrice)).font(.headline)
                                    Button(action:{
                                        buyKokopi()
                                    },label:{
                                        Text("BUY")
                                    }).disabled(n<kokopiPrice)
                                }
                                HStack {
                                    Text(String(pizzaAmount)).font(.title)
                                    Text(String(format: "Pizza COST:%.0f",pizzaPrice)).font(.headline)
                                    Button(action:{
                                        buyPizza()
                                    },label:{
                                        Text("BUY")
                                    }).disabled(n<pizzaPrice)
                                }
                                HStack {
                                    Text(String(nikuAmount)).font(.title)
                                    Text(String(format: "Niku COST:%.0f",nikuPrice)).font(.headline)
                                    Button(action:{
                                        buyNiku()
                                    },label:{
                                        Text("BUY")
                                    }).disabled(n<nikuPrice)
                                }
                            }
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
                    calcKoin()
                }
            }
            .onChange(of: proxy3D.size.width) {
                newWidth,oldWidth in
                isHosonaga = oldWidth < 460
            }
        }
        .background(.blue)

    }
    func buyKokopi() {
        kokopiAmount += 1;
        n -= kokopiPrice;
        kokopiPrice += Double(kokopiAmount) + pow(Double(kokopiAmount),1.08)*0.01
    }
    func buyPizza() {
        pizzaAmount += 1;
        n -= pizzaPrice;
        pizzaPrice += Double(pizzaAmount)*20 + pow(Double(pizzaAmount),1.06)*0.02
    }
    func buyNiku() {
        nikuAmount += 1;
        n -= nikuPrice;
        nikuPrice += Double(nikuAmount)*150 + pow(Double(nikuAmount),1.06)*0.03
    }
    func calcKoinInc() -> Float64 {
        var result:Float64 = 0.0
        result += Double(kokopiAmount)*kokopiOutput
        return result
    }
    func calcKoin() {
        n += calcKoinInc()
    }
    
}
#Preview(windowStyle: .automatic) {
    ContentView()
}
