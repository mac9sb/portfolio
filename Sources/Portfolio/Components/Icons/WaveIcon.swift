import WebUI

struct WaveIcon: Element {
    let size: Int

    init(size: Int = 4) {
        self.size = size
    }

    var body: some Markup {
        Image(
            source:
                "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' stroke='black' stroke-linecap='round' stroke-width='1.5' viewBox='0 0 200 100'%3E%3Cpath d='M20,50 Q40,20 60,50 T100,50 T140,50 T180,50'/%3E%3Cpath d='M50,30 L150,70' opacity='0.1' stroke-width='1'/%3E%3C/svg%3E",
            description: "Wave icon",
            type: .svg
        )
        .frame(width: .spacing(32), height: .spacing(16))
    }
}
