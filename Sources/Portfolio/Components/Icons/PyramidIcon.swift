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
        Stack {
            MarkupString(
                content: """
                    <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" style="width: 100%; height: 100%;">
                        <path d="M50 15 L15 85 L85 85 Z" fill="none" stroke="\(strokeColor)" stroke-width="\(strokeWidth)" stroke-linejoin="round"/>
                        <path d="M50 15 L50 85" stroke="\(strokeColor)" stroke-width="\(strokeWidth)"/>
                        <path d="M15 85 L50 72 L85 85" fill="none" stroke="\(strokeColor)" stroke-width="\(strokeWidth)" stroke-linejoin="round"/>
                    </svg>
                    """)
        }
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
