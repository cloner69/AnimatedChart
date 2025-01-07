//
//  ContentView.swift
//  AnimatedCharts
//
// Created by Adrian Suryo Abiyoga on 06/01/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    ///View Properties
    @State private var appDownloads: [Download] = sampleDownloads
    @State private var isAnimated: Bool = false
    @State private var trigger: Bool = false
    @State var selected = 0
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Chart {
                    ForEach(appDownloads) { download in
                        BarMark(
                            x: .value("Month",download.month),
                            y: .value("Downloads",download.isAnimated ?  download.value : 0)
                        )
                        .foregroundStyle(.green.gradient)
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 2))
                        .opacity(download.isAnimated ? 1 : 0)
                        .symbol {
                            Circle()
                                .fill(.green)
                                .frame(width: 12, height: 12)
                        }
                        
                    
                    }
                    
                }
                .chartYScale(domain: 0...12000)
                .frame(height: 250)
                .padding()
                .background(.background, in: .rect(cornerRadius: 10))
                
                Spacer(minLength: 0)
            }
            .padding()
            .background(.gray.opacity(0.12))
            .navigationTitle("Animated Chart's")
            .onAppear(perform: animateChart)
            .onChange(of: trigger, initial: false) { oldValue, newValue in
                resetChartAnimation()
                animateChart()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Trigger") {
                        trigger.toggle()
                    }
                }
            }
        }
    }
    
    private func animateChart() {
        guard !isAnimated else { return }
        isAnimated = true
        
        $appDownloads.enumerated().forEach { index, element in
            if index > 5 {
                element.wrappedValue.isAnimated = true
            } else {
                let delay = Double(index) * 0.05
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.smooth) {
                        element.wrappedValue.isAnimated = true
                    }
                }
            }
        }
    }
    
    private func resetChartAnimation() {
        $appDownloads.forEach { download in
            download.wrappedValue.isAnimated = false
        }
        
        isAnimated = false
    }
}

#Preview {
    ContentView()
}
