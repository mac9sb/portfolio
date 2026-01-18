import WebUI

struct CodeIcon: Element {
    let size: Int

    init(size: Int = 5) {
        self.size = size
    }

    var body: some Markup {
        Stack {
            MarkupString(
                content: """
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="currentColor" style="width: 100%; height: 100%;">
                        <path d="M320-240 80-480l240-240 57 57-184 184 183 183-56 56Zm320 0-57-57 184-184-183-183 56-56 240 240-240 240Z"/>
                    </svg>
                    """)
        }
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
