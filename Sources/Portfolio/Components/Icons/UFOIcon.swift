import WebUI

struct UFOIcon: Element {
    let size: Int

    init(size: Int = 6) {
        self.size = size
    }

    var body: some Markup {
        Stack {
            MarkupString(
                content: """
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 40" style="width: 100%; height: 100%;">
                        <!-- UFO outline - stroked, no fill -->
                        <!-- Main saucer body -->
                        <ellipse cx="32" cy="28" rx="28" ry="8" fill="none" stroke="currentColor" stroke-width="1.5"/>
                        <!-- Upper dome -->
                        <path d="M20 28 Q20 18 32 18 Q44 18 44 28" fill="none" stroke="currentColor" stroke-width="1.5"/>
                        <!-- Cockpit window -->
                        <ellipse cx="32" cy="22" rx="6" ry="4" fill="none" stroke="currentColor" stroke-width="1"/>
                        <!-- Bottom lights -->
                        <circle cx="18" cy="30" r="2" fill="none" stroke="currentColor" stroke-width="1"/>
                        <circle cx="32" cy="32" r="2" fill="none" stroke="currentColor" stroke-width="1"/>
                        <circle cx="46" cy="30" r="2" fill="none" stroke="currentColor" stroke-width="1"/>
                    </svg>
                    """)
        }
        .frame(width: .spacing(size), height: .spacing(size))
        .addClass("ufo-ship")
    }
}
