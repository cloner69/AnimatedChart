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
                Picker(selection: $selected, label: Text(""), content: {
                               Text("Bar").tag(0)
                               Text("Line").tag(1)
                               Text("Pie").tag(2)
                           }).pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selected, initial: false) { oldValue, newValue in
                        
                        switch newValue {
                        case 0:
                            print("Bar")
                        case 1:
                            print("Line")
                        case 2:
                            print("Pie")
                        default:
                            print("Empty")
                        }
                    }
    
                switch selected {
                                case 0:
                                    BarView(appDownloads: $appDownloads, isAnimated: $isAnimated, trigger: $trigger)
                        .chartYScale(domain: 0...12000)
                        .frame(height: 250)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        
                        Spacer(minLength: 0)
                                case 1:
                    LineView(appDownloads: $appDownloads, isAnimated: $isAnimated, trigger: $trigger)
                        .chartYScale(domain: 0...12000)
                        .frame(height: 250)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        
                        Spacer(minLength: 0)
                                case 2:
                    PieView(appDownloads: $appDownloads, isAnimated: $isAnimated, trigger: $trigger)
                        .chartYScale(domain: 0...12000)
                        .frame(height: 250)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        
                        Spacer(minLength: 0)
                                default:
                                    EmptyView()
                                }
                            
                
                
            }
            .padding()
            .background(.gray.opacity(0.12))
            .navigationTitle("Animated Chart's")
            .onAppear(perform: animateChart)
            .onChange(of: trigger, initial: false) { oldValue, newValue in
                resetChartAnimation()
                animateChart()
            }
            .onChange(of: selected, initial: false) { oldValue, newValue in
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
    
    struct BarView: View {
        @Binding var appDownloads: [Download]
        @Binding var isAnimated: Bool
        @Binding var trigger: Bool

        var body: some View {
            Chart {
                ForEach(appDownloads) { download in
                    BarMark(
                        x: .value("Month", download.month),
                        y: .value("Downloads", download.isAnimated ? download.value : 0)
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
        }
    }
    
    struct LineView: View {
        @Binding var appDownloads: [Download]
        @Binding var isAnimated: Bool
        @Binding var trigger: Bool

        var body: some View {
            Chart {
                ForEach(appDownloads) { download in
                    LineMark(
                        x: .value("Month", download.month),
                        y: .value("Downloads", download.isAnimated ? download.value : 0)
                    )
                    .foregroundStyle(.blue)
                    .interpolationMethod(.catmullRom)
                    .lineStyle(.init(lineWidth: 2))
                    .opacity(download.isAnimated ? 1 : 0)
                    .symbol {
                        Circle()
                            .fill(.blue)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .chartYScale(domain: 0...12000)
            .frame(height: 250)
            .padding()
            .background(.background, in: .rect(cornerRadius: 10))
        }
    }

    struct PieView: View {
        @Binding var appDownloads: [Download]
        @Binding var isAnimated: Bool
        @Binding var trigger: Bool
        
        var body: some View {
            Chart {
                ForEach(appDownloads) { download in
                    SectorMark(
                        angle: .value("Downloads", download.isAnimated ? download.value : 0)
                    )
                    .foregroundStyle(by: .value("Month", download.month))
                }
            }
            .chartLegend(.visible)
            .frame(height: 250)
            .padding()
            .background(.background, in: .rect(cornerRadius: 10))
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
