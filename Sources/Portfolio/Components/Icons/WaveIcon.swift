import WebUI

struct WaveIcon: Element {
    let size: Int

    init(size: Int = 4) {
        self.size = size
    }

    var body: some Markup {
        Stack {
            MarkupString(
                content: """
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-linecap="round" stroke-width="1.5" viewBox="0 0 200 100" style="width: 100%; height: 100%;">
                        <path d="M20,50 Q40,20 60,50 T100,50 T140,50 T180,50"/>
                        <path d="M50,30 L150,70" opacity="0.1" stroke-width="1"/>
                    </svg>
                    """)
        }
        .frame(width: .spacing(32), height: .spacing(16))
    }
}
