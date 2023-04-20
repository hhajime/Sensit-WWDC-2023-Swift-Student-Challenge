//
//  NeonEffect.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/12.
//

import SwiftUI

struct NeonEffect: ViewModifier {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(content
                        .blur(radius: radius)
                        .offset(x: x, y: y)
                        .blendMode(.screen))
            .overlay(content
                        .blur(radius: radius)
                        .offset(x: -x, y: -y)
                        .blendMode(.screen))
            .overlay(color)
            .blendMode(.overlay)
    }
}

extension View {
func addGlowEffect(color1:Color, color2:Color, color3:Color) -> some View {
    self
        .foregroundColor(Color(hue: 0.5, saturation: 0.8, brightness: 1))
        .background {
            self
                .foregroundColor(color1).blur(radius: 0).brightness(0.8)
        }
        .background {
            self
                .foregroundColor(color2).blur(radius: 4).brightness(0.35)
        }
        .background {
            self
                .foregroundColor(color3).blur(radius: 2).brightness(0.35)
        }
        .background {
            self
                .foregroundColor(color3).blur(radius: 12).brightness(0.35)
            
        }
     }
  }
