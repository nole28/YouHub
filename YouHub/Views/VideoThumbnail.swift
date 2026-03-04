//
//  VideoThumbnail.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//


import SwiftUI

struct VideoThumbnail: View {
    let video: Video

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // MARK: - Thumbnail
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: video.thumbnailURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure, .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    @unknown default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(10)
                .clipped()

                Text(video.formattedDuration)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(.black.opacity(0.95))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding([.bottom, .trailing], 8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)

            // MARK: - Video Info
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 36, height: 36)

                VStack(alignment: .leading, spacing: 3) {
                    Text(video.title)
                        .font(.subheadline)
                        .bold()
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("\(video.formattedViews) • \(video.uploadDateText)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
        .padding(.bottom)
        .contentShape(Rectangle())
    }
}

#Preview {
    VideoThumbnail(video: Video.mockData.first!)
        .padding()
}
