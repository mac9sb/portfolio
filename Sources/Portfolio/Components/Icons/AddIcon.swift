import WebUI

struct AddIcon: Element {
    let size: Int

    init(size: Int = 4) {
        self.size = size
    }

    var body: some Markup {
        Stack {
            MarkupString(
                content: """
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="currentColor" style="width: 100%; height: 100%;">
                        <path d="M440-440H200v-80h240v-240h80v240h240v80H520v240h-80v-240Z"/>
                    </svg>
                    """)
        }
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
