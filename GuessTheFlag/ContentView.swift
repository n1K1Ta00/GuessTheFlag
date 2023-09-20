//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Никита Мартьянов on 20.07.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTittle = ""
    @State private var countries = ["Estonia", "France", "Germany",
                     "Ireland","Italy","Nigeria","Poland", "Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var score = 0
    @State private var flag = false
    @State private var animation = 0.0

    
    var body: some View {
        ZStack {
            LinearGradient (gradient: Gradient (colors: [.red, .black]), startPoint: .top,
                            endPoint: .bottom)
                .ignoresSafeArea()
          
            
            VStack (spacing: 30){
                VStack {
                    Text("Выберите флаг страны")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                ForEach(0..<3) {number in
                    let isCorrectAnswer = number == correctAnswer
                    Button {
                        flagTapped(number)
                        if isCorrectAnswer {
                            withAnimation(.linear(duration: 1)) {
                                animation += 360
                            }
                        }
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .rotation3DEffect(.degrees(isCorrectAnswer ? animation : 0), axis: (x: 0, y: 1 , z: 0))
                            .accessibilityLabel(labels[countries[number], default: "Unkown Flag"])
                        
                    }
                }



            }
        
        }
        .alert(scoreTittle, isPresented: $showingScore) {
            Button ("Продолжить", action: askQustion)
        }
            message: {
                Text("Твой счет \(score)")
        }
    }
    func flagTapped(_ number:Int ){
        if number == correctAnswer{
            score = score+1
            if score < 0 {
                score = 0
            }
            scoreTittle="Правильно"
        }
        else {
            score = score-1
            scoreTittle = "Неправильно"
            if score < 0 {
                score = 0
            }
            // уменьшаем масштаб и делаем флаг менее ярким для невыбранного флага
            withAnimation(.easeOut) {
                Image(countries[correctAnswer])
                    .renderingMode(.original)
                    .scaleEffect(0.5)
                    .opacity(0.5)
            
        
        showingScore = true
    }


            
        }
        showingScore = true

    }
    func askQustion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
