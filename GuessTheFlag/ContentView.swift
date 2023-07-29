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
    @State private var score = 0

    
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
                    Button {
                        flagTapped(number)
                        
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
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
