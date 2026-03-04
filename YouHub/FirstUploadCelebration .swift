//
//  FirstUploadCelebration .swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct FirstUploadCelebrationView: View {
    @Binding var isPresented: Bool
    @State private var confettiScale: CGFloat = 0.5
    @State private var confettiOpacity: Double = 0
    @State private var textScale: CGFloat = 0.8
    @State private var textOpacity: Double = 0

    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Confetti
                Image(systemName: "sparkles")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                    .scaleEffect(confettiScale)
                    .opacity(confettiOpacity)
                    .rotationEffect(.degrees(confettiScale * 360))

                // Celebration text
                VStack(spacing: 8) {
                    Text("🎉 First Video Uploaded!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .scaleEffect(textScale)
                        .opacity(textOpacity)

                    Text("Your video is now live!")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .scaleEffect(textScale)
                        .opacity(textOpacity)

                    Text("Share it with friends or check analytics")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }

                // Dismiss button
                Button("Got it!") {
                    withAnimation(.easeOut(duration: 0.3)) { isPresented = false }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.top, 10)
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(color: .black.opacity(0.3), radius: 20)
            )
            .padding(40)
        }
        .onAppear {
            // Animate confetti
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                confettiScale = 1.2
                confettiOpacity = 1
            }

            // Animate text slightly after
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    textScale = 1
                    textOpacity = 1
                }
            }

            // Auto-dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation { isPresented = false }
            }
        }
    }
}
