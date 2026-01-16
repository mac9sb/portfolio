import WebUI

struct PyramidIcon: Element {
    let size: Int
    let strokeColor: String
    let strokeWidth: Double

    init(size: Int = 8, strokeColor: String = "currentColor", strokeWidth: Double = 1.5) {
        self.size = size
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
    }

    var body: some Markup {
        Image(
            source:
                "data:image/svg+xml,%3Csvg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M50 15 L15 85 L85 85 Z' fill='none' stroke='\(strokeColor.replacingOccurrences(of: "#", with: "%23"))' stroke-width='\(strokeWidth)' stroke-linejoin='round'/%3E%3Cpath d='M50 15 L50 85' stroke='\(strokeColor.replacingOccurrences(of: "#", with: "%23"))' stroke-width='\(strokeWidth)'/%3E%3Cpath d='M15 85 L50 72 L85 85' fill='none' stroke='\(strokeColor.replacingOccurrences(of: "#", with: "%23"))' stroke-width='\(strokeWidth)' stroke-linejoin='round'/%3E%3C/svg%3E",
            description: "Pyramid logo",
            type: .svg
        )
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
